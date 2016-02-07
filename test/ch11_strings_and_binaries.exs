defmodule Ch11Test do
  use ExUnit.Case

  test "string interpolation" do
    name = "dave"
    result = "Hello, #{String.capitalize name}"
    assert result == "Hello, Dave"
  end

  test "sigils - delimiters" do
    # <...>, {...}, [...], (...), |...|, /.../, "...", and '...'.
    assert ~C<ABC> == 'ABC'
    assert ~C{ABC} == 'ABC'
    assert ~C[ABC] == 'ABC'
    assert ~C(ABC) == 'ABC'
    assert ~C|ABC| == 'ABC'
    assert ~C/ABC/ == 'ABC'
    assert ~C"ABC" == 'ABC'
    assert ~C'ABC' == 'ABC'
  end


  test "sigils - ~C - A character list with no escaping or interpolation" do
    assert ~C[1\n2#{1+2}] == '1\\n2\#{1+2}'
  end

  test "sigils - ~c - A character list, escaped and interpolated just like a single-quoted string" do
    assert ~c"1\n2#{1+2}" == '1\n23'
  end

  test "sigils - ~W - A list of whitespace-delimited words, with no escaping or interpolation" do
    assert ~W[the c#{'a'}t sat on the mat] == ["the", "c\#{'a'}t", "sat", "on", "the", "mat"]
  end

  test "sigils - ~w - A list of whitespace-delimited words, with escaping and interpolation" do
    assert ~w[the c#{'a'}t sat on the mat] == ["the", "cat", "sat", "on", "the", "mat"]
  end

  test "single quoted string is a list of character codes" do
    assert is_list('abc') == true
    assert Enum.reverse('abc') == 'cba'
    assert length('abc') == 3

    assert 'CAT' == [ 67, 65, 84 ]
  end

  test "single quoted string functions" do
    str = 'wombat'
    assert List.to_tuple(str) == {119, 111, 109, 98, 97, 116}
    assert (str ++ [0]) == [119, 111, 109, 98, 97, 116, 0]
  end

  test "binaries" do
    b = <<1, 2, 3>>
    assert byte_size(b) == 3
    assert bit_size(b) == 24
  end

  test "double-quoted strings are just binaries" do
    dqs = "∂x/∂y"
    assert String.length(dqs) == 5
    assert byte_size(dqs) == 9
    assert String.at(dqs, 0) == "∂"
    assert String.codepoints(dqs) == ["∂", "x", "/", "∂", "y"]
    assert String.split(dqs, "/") == ["∂x", "∂y"]
  end
end