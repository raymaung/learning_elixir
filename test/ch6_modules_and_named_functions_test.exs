defmodule Ch6ModulesAndNamedFunctionsTest do
  use ExUnit.Case

  test "simple modules" do
    defmodule Times do
      def double(n) do
        n * 2
      end
    end
    assert Times.double(2) == 4
  end

  test "module function as one-line" do
    defmodule Times do
      def triple(n), do: n * 3
    end

    assert Times.triple(3) == 9
  end

  test "module function with parentenese as block" do

    defmodule Times do
      def triple(n), do: (
        n * 3
      )
    end

    assert Times.triple(3) == 9
  end

  test "module using parenteses (don't do it)" do
    defmodule Times, do: (def double(n), do: (n * 2))
    assert Times.double(2) == 4
  end

end
