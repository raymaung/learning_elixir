defmodule Ch8DictMapsHashTest do
  use ExUnit.Case

  test "sum using dict" do
    defmodule Sum do
      def values(dict) do
        dict |> Dict.values |> Enum.sum
      end
    end

    hd = [ one: 1, two: 2, three: 3] |> Enum.into HashDict.new
    assert Sum.values(hd) == 6

    map = %{ four: 4, five: 5, six: 6 }
    assert Sum.values(map) == 15
  end

  test "pattern matching and updating maps" do
    person = %{ name: "Dave", height: 1.88 }
    %{ name: a_name } = person
    assert a_name == "Dave"

    # %{ name: _, height: _ } = person
    assert %{ name: "Dave" } = person

  end

  test "query map" do
    people = [
      %{ name: "Grumpy",    height: 1.24 },
      %{ name: "Dave",      height: 1.88 },
      %{ name: "Dopey",     height: 1.88 },
      %{ name: "Shaquille", height: 2.16 },
      %{ name: "Sneezy",    height: 1.28 }
    ]

    by_height = fn (%{height: height}) ->
      height > 1.5
    end

    tall_people = people |> Enum.filter(by_height)
    assert tall_people == [
      %{ name: "Dave",      height: 1.88 },
      %{ name: "Dopey",     height: 1.88 },
      %{ name: "Shaquille", height: 2.16 }
    ]
  end

  test "updating a map" do
    m = %{ a: 1, b: 2, c: 3 }
    m1 = %{ m | b: "two", c: "three" }
    m2 = %{ m1 | a: "one" }

    assert m1 == %{ a: 1, b: "two", c: "three" }
    assert m2 == %{ a: "one", b: "two", c: "three"}
  end

  test "maps and structs" do
    s1 = %Ch8.Subscriber{}
    assert s1.name == ""

    s2 = %Ch8.Subscriber { name: "Dave" }
    assert s2.name == "Dave"
    assert s2.paid == false
    assert s2.over_18 == true
  end

  test "using Attendee destruct" do
    a1 = %Ch8.Attendee{ name: "Dave", over_18: true }
    assert Ch8.Attendee.may_attend_after_party(a1) == false

    a2 = %Ch8.Attendee{ a1 | paid: true}
    assert Ch8.Attendee.may_attend_after_party(a2) == true
  end

  test "nested dictionary structures" do

    report = %Ch8.BugReport {
      owner: %Ch8.Customer{ name: "Dave", company: "Pragmatic" },
      details: "broken"
    }
    assert report.owner.company == "Pragmatic"

    # Long Verbose Way
    report = %Ch8.BugReport { report |
      owner: %Ch8.Customer { report.owner |
        company: "PragProg"
      }
    }
    assert report.owner.company == "PragProg"

    # Using put_in macro - to update value in nested structure
    report = put_in(report.owner.company, "PragProg-2")
    assert report.owner.company == "PragProg-2"

    # Using update_in to apply function to value
    report = update_in report.owner.name, &("Mr. " <> &1)
    assert report.owner.name == "Mr. Dave"

    # Using key symbols for maps or keyword list
    # Note, it is a simple map - not struct
    report = %{ owner: %{ name: "Dave", company: "Pragmatic" }, severity: 1}
    report = put_in report[:owner][:name], "Dave"
    assert report.owner.name == "Dave"
  end

  test "update nested structure using dynamic keys" do
    nested = %{
      buttercup: %{
        actor: %{
          first: "Robin",
          last: "Wright"
        },
        role: "princess"
      },
      westley: %{
        actor: %{
          first: "Carey",
          last: "Ewes"
        },
        role: "farm boy"
      }
    }

    assert get_in(nested, [:buttercup]) == %{
      actor: %{
        first: "Robin",
        last: "Wright"
      },
      role: "princess"
    }

    assert get_in(nested, [:buttercup, :actor]) == %{
      first: "Robin",
      last: "Wright"
    }

    assert get_in(nested, [:buttercup, :actor, :first]) == "Robin"
  end

  test "dynamic keys - a function as key" do
    authors = [
      %{ name: "José", language: "Elixir"  },
      %{ name: "Matz",  language: "Ruby"    },
      %{ name: "Larry", language: "Perl"    }
    ]

    languages_with_an_r = fn
      (:get, collection, next_fn) ->
        for row <- collection do
          if String.contains?(row.language, "r") do
            next_fn.(row)
          end
        end
      end

    assert get_in(authors, [languages_with_an_r, :name]) == [
      "José",
      nil,
      "Larry"
    ]
  end

end

