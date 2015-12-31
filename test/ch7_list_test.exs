defmodule Ch7ListTest do
  use ExUnit.Case

  test "count list item" do
    defmodule MyList do
      def len([]), do: 0
      def len([_head | tail]), do: 1 + len(tail)
    end

    assert MyList.len([]) == 0
    assert MyList.len([1, 2]) == 2
  end

  test "recursion sum" do
    defmodule MyListSumRecursion do
      def sum(list), do: _sum(list, 0)
      defp _sum([], total), do: total
      defp _sum([head | tail], total), do: _sum(tail, total + head)
    end

    assert MyListSumRecursion.sum([1, 2, 3]) == 6
  end

  test "recursion reduce" do
    defmodule MyListReduce do
      def reduce([], value, _), do: value
      def reduce([head | tail], value, func) do
        reduce tail, func.(head, value), func
      end
    end
    assert MyListReduce.reduce([1, 2, 3], 0, fn e, acc -> e + acc end) == 6
  end

  test "weather history" do
    expected = [
      [1366225622, 27, 15, 0.45],
      [1366229222, 27, 17, 0.468],
      [1366232822, 27, 21, 0.05]
    ]

    assert Ch7List.WeatherHistory.for_location_27(Ch7List.test_data) == expected
    assert Ch7List.WeatherHistory.for_location(Ch7List.test_data, 27) == expected
    assert Ch7List.WeatherHistory.for_location_using_head(Ch7List.test_data, 27) == expected

  end

  test "sum the list using reduce" do
    defmodule MySumList do
      def sum(list), do: _reduce(list, 0, &(&1 + &2))
      defp _reduce([], total, _func), do: total
      defp _reduce([head | tail], total, func), do: _reduce(tail, func.(head, total), func)
    end

    assert MySumList.sum([]) == 0
    assert MySumList.sum([1]) == 1
    assert MySumList.sum([1, 2, 3, 4]) == 10
  end
end

