defmodule Ch6ModulesAndNamedFunctionsTest do
  use ExUnit.Case, async: true

  test "simple modules" do
    defmodule Times1 do
      def double(n) do
        n * 2
      end
    end
    assert Times1.double(2) == 4
  end

  test "module function as one-line" do
    defmodule Times2 do
      def triple(n), do: n * 3
    end

    assert Times2.triple(3) == 9
  end

  test "module function with parentenese as block" do

    defmodule Times3 do
      def triple(n), do: (
        n * 3
      )
    end

    assert Times3.triple(3) == 9
  end

  test "module using parenteses (don't do it)" do
    defmodule Times4, do: (def double(n), do: (n * 2))
    assert Times4.double(2) == 4
  end

  test "pattern matching function calls" do
    defmodule Factorial do
      def of(0), do: 1
      def of(n), do: n * of(n - 1)
    end

    assert Factorial.of(0) == 1
    assert Factorial.of(3) == 6
  end

  test "guard causes" do
    defmodule Guard do
      def what_is(x) when is_number(x) do
        "number"
      end

      def what_is(x) when is_list(x) do
        "list"
      end

      def what_is(x) when is_atom(x) do
        "atom"
      end
    end

    assert Guard.what_is(1) == "number"
  end

  test "default parameters" do
    defmodule DefaultParameters do
      def func(a \\ 1) do
        a
      end
    end

    assert DefaultParameters.func() == 1
    assert DefaultParameters.func(2) == 2
  end

  test "pipe" do
    pipe_result = (1..10)
                    |> Enum.map(&(&1*&1))
                    |> Enum.filter(&(&1 < 40))
    assert pipe_result == [1, 4, 9, 16, 25, 36]
  end

  test "nesting modules" do
    defmodule Outer do
      defmodule Inner do
        def inner_func do
          1
        end
      end
      def outer_func do
        2 + Inner.inner_func()
      end
    end

    assert Outer.outer_func() == 3

  end

  test "importing modules" do
    defmodule MyList do
      import List, only: [flatten: 1]

      def my_flatten(l) do
        flatten l
      end
    end

    assert MyList.my_flatten([[1, 2]]) == [1, 2]
  end

  test "alias example" do
    defmodule AliasExample do
      alias Enum, as: MyEnum
      def count(l), do: MyEnum.count l
    end
    assert AliasExample.count([1]) == 1
  end

  test "module attribute example" do
    defmodule ModuleAttributeExample do
      @author "Dave Thomas"
      def get_author do
        @author
      end
    end

    assert ModuleAttributeExample.get_author == "Dave Thomas"
  end

  test "module attribute - redefine attr" do
    defmodule ModuleAttributeRedefineAttrExample do
      @author "one"
      def first_author, do: @author

      @author "two"
      def second_author, do: @author
    end

    assert ModuleAttributeRedefineAttrExample.first_author == "one"
    assert ModuleAttributeRedefineAttrExample.second_author == "two"
  end
end


