defmodule Ch5AnonymousFunctionsTest do
  use ExUnit.Case

  doctest Ch5AnonymousFunctions

  test "function returns function" do
    add_n = fn n ->
      fn other -> n + other end
    end

    add_two = add_n.(2)
    assert add_two.(1) == 3
  end

  test "passing functions as arguments" do
    times_2 = fn n -> n * 2 end
    apply = fn (fun, value) -> fun.(value)  end

    assert apply.(times_2, 3) == 6
  end

  test "short-hand function" do
    add_one = &(&1 + 1)
    assert add_one.(2) == 3
  end

  test "bind function" do
    count = &Enum.count/1
    assert count.([1, 2]) == 2

    sum = fn a, b -> a + b end
    s = sum
    assert s.(1, 2) == 3
  end
end
