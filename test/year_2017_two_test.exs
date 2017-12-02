defmodule Year2017Test.Two do
  use ExUnit.Case

  test "calculates checksum with min max entries in each row" do
    result = "5 1 9 5\n7 5 3\n2 4 6 8\n"
      |> Year2017.Two.part_one
    assert result == 18
  end

  test "solves part one" do
    IO.puts "\nsolution to day 2 part one:"
    File.read!('./lib/inputs/Two.input')
      |> Year2017.Two.part_one
      |> IO.puts
  end

  test "calculates checksum with numbers that divide without remainder in each row" do
    result = "5 9 2 8\n9 4 7 3\n3 8 6 5"
      |> Year2017.Two.part_two
    assert result == 9
  end

  test "solves part two" do
    IO.puts "\nsolution to day 2 part two:"
    File.read!('./lib/inputs/Two.input')
      |> Year2017.Two.part_two
      |> IO.puts
  end
end
