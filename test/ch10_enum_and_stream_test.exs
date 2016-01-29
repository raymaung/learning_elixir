defmodule Ch10Test do
  use ExUnit.Case

  test "Enum to_list" do
    list = Enum.to_list 1..5
    assert list == [1, 2, 3, 4, 5]
  end

  test "Enum#concat" do
    list = Enum.concat [1, 2, 3], [4, 5]
    assert list == [1, 2, 3, 4, 5]
  end

  test "Enum#map" do
    list = Enum.map [1, 2, 3], &(&1 * 10)
    assert list == [10, 20, 30]

    list = Enum.map [1, 2, 3], &String.duplicate("*", &1)
    assert list == ["*", "**", "***"]
  end

  test "Enum#filter" do
    require Integer
    list = Enum.filter [1, 2, 3, 4, 5], &Integer.is_even/1
    assert list == [2, 4]
  end

  test "Stream#map" do
    list = Stream.map([1, 3, 5, 7], &(&1 + 1))
            |> Enum.to_list
    assert list == [ 2, 4, 6, 8 ]
  end

  test "Stream#chain map" do
    list = [1,2,3,4]
            |> Stream.map(&(&1*&1))
            |> Stream.map(&(&1+1))
            |> Stream.filter(fn x -> rem(x,2) == 1 end)
            |> Enum.to_list
    assert list == [5, 17]
  end

  test "For - syntax examples" do
    list = for x <- [1, 2], do: x * x
    assert list == [1, 4]

    list = for x <- [1, 2] do
            x
          end
    assert list == [1, 2]

    list = for x <- [1, 2], y <- ['a', 'b'] do
      {x, y}
    end
    assert list == [ {1, 'a'}, {1, 'b'}, {2, 'a'}, {2, 'b'} ]
  end

  test "For - with conditions" do
    first8 = [ 1, 2, 3, 4, 5, 6, 7, 8]
    list = for x <- first8,
              y <- first8,
              x >= y,
              rem(x * y, 10) == 0 do
            { x, y }
    end
    assert list == [{5, 2}, {5, 4}, {6, 5}, {8, 5}]
  end

  test "For - deconstrucing element" do
    reports = [ dallas: :hot, minneapolis: :cold, dc: :muggy, la: :smoggy ]
    new_reports = for {city, weather} <- reports, do: { weather, city}
    assert new_reports == [ hot: :dallas, cold: :minneapolis, muggy: :dc, smoggy: :la ]
  end

  test "For - Works on Bits" do
    list = for << ch <- "hello" >>, do: ch

    assert list == 'hello'
    assert list != "hello"
  end

  test "For - scoping" do
    name = "Dave"
    for name <- [ "CAT", "DOG"], do: name
    assert name == "Dave"
  end

  test "For - into" do
    result = for x <- ~w{ cat dog }, into: %{}, do: { x, String.upcase(x) }
    assert result == %{ "cat" => "CAT", "dog" => "DOG" }

    result = for x <- ~w{ cat dog }, into: Map.new, do: { x, String.upcase(x) }
    assert result == %{ "cat" => "CAT", "dog" => "DOG" }

    result = for x <- ~w{ cat dog }, into: %{"ant" => "ANT"}, do: { x, String.upcase(x) }
    assert result == %{"ant" => "ANT", "cat" => "CAT", "dog" => "DOG"}
  end

end

