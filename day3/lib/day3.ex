defmodule Day3 do
  def parse_input(input) do
    String.split(input, ["@", " ", ",", ":", "x", "#"], trim: true)
    |> Enum.map(&(String.to_integer/1))
  end

  def convert_to_coordinates(list) do
    [_id, col_start, row_start, width, length] = list

    columns = width-1..0
    rows = length-1..0

    Enum.reduce(rows, [], fn i, acc ->
      Enum.reduce(columns, acc, fn j, acc ->
        [{col_start + j, row_start + i} | acc]
      end)
    end)
  end

  def count_coordinates(list) do
    Enum.reduce(list, %{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

  def count_multiples(coordinate_counter) do
    Map.values(coordinate_counter)
    |> Enum.count(fn x -> x > 1 end)
  end

  def count_multiple_claimed_squares(input) do
    input
    |> Enum.map(&parse_input/1)
    |> Enum.map(&convert_to_coordinates/1)
    |> List.flatten()
    |> count_coordinates()
    |> count_multiples()
  end

  def part_1(input) do
    File.stream!(input)
    |> Stream.map(&String.trim_trailing/1)
    |> count_multiple_claimed_squares()
  end
end
