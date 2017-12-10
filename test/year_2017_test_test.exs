defmodule Year2017Test.Ten do
  use ExUnit.Case

  import Year2017.Ten

  test " reverses a sublist that does not wrap" do
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
end
