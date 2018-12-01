defmodule Exercise2 do
  def find_repeating(input) do
    File.stream!(input)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn x, {current, seen} ->
      new_freq = current + x
      if MapSet.member?(seen, new_freq) do
        {:halt, new_freq}
      else
        {:cont, {new_freq, MapSet.put(seen, new_freq)}}
      end
    end)
  end
end

ExUnit.start()

defmodule Exercise2Test do
  use ExUnit.Case

  import Exercise2

  test "find repeating frequency" do
    assert find_repeating("./test_input") == 5
  end
end

IO.puts "First Repeats: #{Exercise2.find_repeating("./input")}"
