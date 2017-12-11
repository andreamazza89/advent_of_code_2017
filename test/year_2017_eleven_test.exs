defmodule Year2017Test.Eleven do
  use ExUnit.Case

  import Year2017.Eleven

  test "follows coordinates one step" do
    [
      {{1, -1}, "n", {1, -2}},
      {{-2, 2}, "ne", {-1, 1}},
      {{0, 0}, "se", {1, 0}},
      {{0, 0}, "se", {1, 0}},
      {{-1, 2}, "s", {-1, 3}},
      {{-2, 2}, "sw", {-3, 3}},
      {{-2, 2}, "nw", {-3, 2}},
    ]
      |> Enum.map(fn({from, direction, to}) ->

        assert move(from, direction) == to

      end)
  end

  test "finds the shortest number of steps to the center" do
    assert shortest_path_via_diagonal({1,2}) == 3
    assert shortest_path_via_diagonal({-1,2}) == 2
    assert shortest_path_via_diagonal({1,0}) == 1
  end

  test "solves part one and two" do
    IO.puts "solution to day 11 part one and two"
    File.read!('./lib/inputs/Eleven.input')
      |> part_one
      |> IO.inspect
  end

end
