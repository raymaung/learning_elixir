defmodule Ch9_Aside_Test do
  use ExUnit.Case

  test "Sets Exaples" do
    set1 = Enum.into 1..5, HashSet.new
    set2 = Enum.into 3..8, HashSet.new

    unionSet = Set.union set1, set2
    assert HashSet.to_list(unionSet) |> Enum.sort == [ 1, 2, 3, 4, 5, 6, 7, 8 ]
  end
end

