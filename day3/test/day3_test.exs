defmodule Day3Test do
  use ExUnit.Case

  import Day3

  test "parse input line" do
    assert parse_input("#666 @ 590,650: 25x12") == [666, 590, 650, 25, 12]
  end

  test "convert to coordinates to store" do
    assert convert_to_coordinates([1, 1, 3, 3, 3]) == [
      {1,3}, {2,3}, {3,3},
      {1,4}, {2,4}, {3,4},
      {1,5}, {2,5}, {3,5},
    ]
  end

  test "count coordinates" do
    assert count_coordinates([{1,1}, {1,1}, {1,2}, {2,2}, {1,2}]) == %{{1,1} => 2, {1,2} => 2, {2,2} => 1}
  end

  test "count multiple claimed coordinates" do
    assert count_multiples(%{{1,1} => 1, {1,2} => 2, {2,2} => 2}) == 2
  end

  test "count multiple claimed squares" do
    input = [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2",
    ]

    assert count_multiple_claimed_squares(input) == 4
  end

  test "process part_1" do
    assert part_1("./test/test_input") == 4
  end
end
