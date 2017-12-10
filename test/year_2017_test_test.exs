defmodule Year2017Test.Ten do
  use ExUnit.Case

  import Year2017.Ten

  test "reverses a sublist that does not wrap" do
    result = [0, 1, 2, 3, 4]
      |> wrap_reverse(0, 3)

    assert result == [2, 1, 0, 3, 4]
  end

  test "reverses a sublist that wraps" do
    result = [2, 1, 0, 3, 4]
      |> wrap_reverse(3, 4)

    assert result == [4, 3, 0, 1, 2]
  end

  test "solves part one" do
    IO.puts "solution to day 10 part one"
    [18,1,0,161,255,137,254,252,14,95,165,33,181,168,2,188]
      |> part_one
      |> IO.inspect
  end

  test "densifies a block" do
    result = [65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22]
      |> densify

    assert result == 64
  end

  test "hashes AoC 2017" do
    result = 'AoC 2017' ++ [17, 31, 73, 47, 23]
      |> part_two

    assert result == "33efeb34ea91902bb2f59c9920caa6cd"
  end

  test "solves part two" do
    IO.puts "solution to day 10 part two"
    '18,1,0,161,255,137,254,252,14,95,165,33,181,168,2,188' ++ [17, 31, 73, 47, 23]
      |> part_two
      |> IO.inspect
  end
end
