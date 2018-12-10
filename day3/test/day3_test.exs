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

  test "process part 1" do
    assert part_1("./test/test_input") == 4
  end

  test "process part 2" do
    assert part_2("./test/test_input") == 3
  end
end
