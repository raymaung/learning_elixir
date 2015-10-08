defmodule Ch5AnonymousFunctions do

  @doc """
    iex> sum = fn (a, b) -> a + b end
    iex> sum.(1, 2)
    3

    Omit the parentheses in a function definition
    iex> sum = fn a, b -> a + b end
    iex> sum.(1, 2)
    3

    Pattern matching
    iex> swap = fn ({a, b}) -> {b, a} end
    iex> swap.({6, 8})
    {8, 6}
  """

  def defining_anonymous_functions do
  end

end
