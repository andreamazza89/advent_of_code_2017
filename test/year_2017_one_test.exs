defmodule Year2017Test.One do
  use ExUnit.Case

  test "ignores any numbers that are not repeated" do
    result = [1, 2, 3, 4]
      |> Year2017.One.count(1)
    assert result == 0
  end

  test "counts any numbers that are repeated" do
    result = [1, 2, 3, 3, 4]
      |> Year2017.One.count(1)
    assert result == 3
  end

  test "counts any numbers that are repeated, wrapping over to the start" do
    result = [4, 1, 2, 3, 3, 4]
      |> Year2017.One.count(1)
    assert result == 7
  end

  test "solve part one" do
    IO.puts("\nsolution to part one:")
    Year2017.One.readInput
      |> Year2017.One.count(1)
      |> IO.puts
  end

  test "solve part two" do
    steps = div(length(Year2017.One.readInput),2)
    IO.puts("\nsolution to part two:")
    Year2017.One.readInput
      |> Year2017.One.count(steps)
      |> IO.puts
  end

end
