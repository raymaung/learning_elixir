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
end

