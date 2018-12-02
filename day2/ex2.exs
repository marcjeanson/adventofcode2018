defmodule Exercise2 do
  # https://en.wikipedia.org/wiki/Hamming_distance
  def hamming_distance(str1, str2) do
    Enum.zip(String.codepoints(str1), String.codepoints(str2))
    |> Enum.count(fn {x, y} -> x != y end)
  end

  # ruby has combination, but not in elixir
  # https://rosettacode.org/wiki/Combinations#Elixir
  def combination(0, _), do: [[]]
  def combination(_, []), do: []
  def combination(n, [x|xs]) do
    (for y <- combination(n - 1, xs), do: [x|y]) ++ combination(n, xs)
  end

  def find_best_pair(ids) do
    combination(2, ids)
    |> Enum.find(fn x -> hamming_distance(List.first(x), List.last(x)) == 1 end)
  end

  def common_letters(str1, str2) do
    Enum.zip(String.codepoints(str1), String.codepoints(str2))
    |> Enum.filter(fn {x, y} -> x == y end)
    |> Enum.map(fn {x, _y} -> x end)
    |> Enum.join
  end

  def common_letters_for_best_pair(input) do
    best_pair = File.stream!(input)
    |> Enum.map(&String.trim_trailing/1)
    |> find_best_pair()

    common_letters(List.first(best_pair), List.last(best_pair))
  end
end

ExUnit.start()

defmodule Exercise2Test do
  use ExUnit.Case

  import Exercise2

  test "generate a collection of all id pairs" do
    assert combination(2, ["aa", "bb", "cc"]) == [["aa", "bb"], ["aa", "cc"], ["bb", "cc"]]
  end

  test "hamming distance between strings" do
    assert hamming_distance("abcde", "abcde") == 0
    assert hamming_distance("abcde", "accde") == 1
    assert hamming_distance("abcde", "zccde") == 2
  end

  test "find the id pair with hammming distance of 1" do
    ids = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]
    assert find_best_pair(ids) == ["fghij", "fguij"]
  end

  test "common letters between two strings" do
    assert common_letters("", "") == ""
    assert common_letters("abc", "def") == ""
    assert common_letters("fghij", "fguij") == "fgij"
  end

  test "common letters for the best pair" do
    assert common_letters_for_best_pair("./test_input_2") == "fgij"
  end
end

IO.puts "Common letters for two correct box IDs: #{Exercise2.common_letters_for_best_pair("./input")}"
