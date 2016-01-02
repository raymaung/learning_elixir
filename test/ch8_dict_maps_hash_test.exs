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


end

