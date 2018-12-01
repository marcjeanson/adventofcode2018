defmodule Exercise1 do
  def calibrate(input) do
    File.stream!(input)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum
  end
end

ExUnit.start()

defmodule Exercise1Test do
  use ExUnit.Case

  import Exercise1

  test "process frequency changes" do
    assert calibrate("./test_input") == 4
  end
end

IO.puts "Calibrate to: #{Exercise1.calibrate("./input")}"
