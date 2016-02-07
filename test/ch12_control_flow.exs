defmodule Ch12Test do
  use ExUnit.Case

  test "if - short hand" do
    result = if 1 == 2, do: 1, else: 2
    assert result == 2
  end

  test "if - long hand" do
    result = if 1 == 2 do
      1
    else
      2
    end
    assert result == 2
  end

  test "unless - short hand" do
    result = unless 1 == 2, do: 1, else: 2
    assert result == 1
  end

  test "unless - long hand" do
    result = unless 1 == 2 do
      1
    else
      2
    end
    assert result == 1
  end

  test "cond examples" do
    x = 2
    result =
      cond do
        x == 1 -> 1
        x == 2 -> 2
      end
    assert result == 2
  end

  test "case" do
    dave = %{ name: "Dave", state: "TX", likes: "programming" }
    result = case dave do
      %{ state: "TX" } = person ->
        "Texan"
      _ -> "Unknown"
    end
    assert result == "Texan"
  end
end
