defmodule Year2017Test.Four do
  use ExUnit.Case

  test "counts how many lines have no duplicate words" do
    result = "aa aa ff rty\naa bb cc dd\naa cc\naa aa\n"
      |> Year2017.Four.count_lines_with_unique_words
    assert result == 2
  end

  test "solves part one" do
    IO.puts "solution to day 4 part one:"
    File.read!('./lib/inputs/Four.input')
      |> Year2017.Four.count_lines_with_unique_words
      |> IO.inspect
  end

  test "counts how many lines have no double anagram words" do
    result = "abcde fghij\nabcde xyz ecdab\na ab abc abd abf abj\noiii ioii iioi iiio\niiii oiii ooii oooi oooo\n"
      |> Year2017.Four.count_lines_with_anagrams
    assert result == 3
  end

  test "solves part two" do
    IO.puts "solution to day 4 part two:"
    File.read!('./lib/inputs/Four.input')
      |> Year2017.Four.count_lines_with_anagrams
      |> IO.inspect
  end

end
