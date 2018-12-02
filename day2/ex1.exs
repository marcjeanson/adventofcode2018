defmodule Exercise1 do
  def checksum(input) do
    freqs = File.stream!(input)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.map(&letter_frequencies/1)

    twos = Enum.count(freqs, &has_freq_x?(2, &1))
    threes = Enum.count(freqs, &has_freq_x?(3, &1))

    twos * threes
  end

  def letter_frequencies(input) do
    String.codepoints(input)
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

  def has_freq_x?(x, freqs) do
    Map.values(freqs)
    |> Enum.any?(&(&1 == x))
  end
end

ExUnit.start()

defmodule Exercise1Test do
  use ExUnit.Case

  import Exercise1

  test "calculate letter frequencies" do
    assert letter_frequencies("abcb") == %{"a" => 1, "b" => 2, "c" => 1}
    assert letter_frequencies("aacbc") == %{"a" => 2, "b" => 1, "c" => 2}
  end

  test "that a letter with desired frequency exists" do
    assert has_freq_x?(2, %{}) == false
    assert has_freq_x?(2, %{"a" => 1, "b" => 2, "c" => 1}) == true
    assert has_freq_x?(2, %{"a" => 1, "b" => 2, "c" => 2}) == true
    assert has_freq_x?(2, %{"a" => 1, "b" => 1, "c" => 3}) == false
    assert has_freq_x?(3, %{"a" => 1, "b" => 2, "c" => 2}) == false
    assert has_freq_x?(3, %{"a" => 1, "b" => 1, "c" => 3}) == true
  end

  test "calculate checksum" do
    assert checksum("./test_input") == 12
  end
end

IO.puts "Checksum is: #{Exercise1.checksum("./input")}"
