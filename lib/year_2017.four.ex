defmodule Year2017.Four do

  def count_lines_with_unique_words(lines) do
    lines
      |> String.split("\n", trim: true)
      |> Enum.filter(&all_words_in_line_are_unique/1)
      |> length
  end

  defp all_words_in_line_are_unique(line) do
    length_before_uniquing = line
      |> String.split(" ", trim: true)
      |> length

    length_after_uniquing = line
      |> String.split(" ", trim: true)
      |> Enum.uniq
      |> length

    length_before_uniquing == length_after_uniquing
  end

  def count_lines_with_anagrams(lines) do
    lines
      |> String.split("\n", trim: true)
      |> Enum.filter(&has_no_anagrams/1)
      |> length
  end

  defp has_no_anagrams(line) do
    length_before_uniquing = line
      |> String.split(" ", trim: true)
      |> length

    length_after_uniquing = line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.sort/1)
      |> Enum.uniq
      |> length

    length_before_uniquing == length_after_uniquing
  end

end
