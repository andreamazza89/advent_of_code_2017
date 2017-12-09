defmodule Year2017Test.Nine do
  use ExUnit.Case

  import Year2017.Nine

  test "scoring a single group" do
    result = '{}'
      |> score

    assert result == 1
  end

  test "scoring two level of nesting" do
    result = '{{}}'
      |> score

    assert result == 3
  end

  test "scoring many levels of nesting and multiple groups per level" do
    result = '{{{},{},{{}}}}'
      |> score

    assert result == 16
  end

  test "removes items to be ignored" do
    result = "fkd!jafdn{!!,f!<fdf!><!!!>>"
      |> remove_ignorables

    assert result == "fkdafdn{,ffdf<>"
  end

  test "removes the garbage" do
    result = "asd<aererer>fef<><>efsa<df<<>"
      |> clean_garbage

    assert result == "asdfefefsa"
  end

  test "solves part one" do
    IO.puts "solution to day 9 part one"
    File.read!('./lib/inputs/Nine.input')
      |> part_one
      |> IO.inspect
  end

  test "keeps the garbage contents" do
    result = "asd<aererer>fef<><>efsa<df<<>"
      |> keep_garbage

    assert result == [["<aererer>"], ["<>"], ["<>"], ["<df<<>"]]
  end

  test "solves part two" do
    IO.puts "solution to day 9 part two"
    File.read!('./lib/inputs/Nine.input')
      |> part_two
      |> IO.inspect
  end
end
