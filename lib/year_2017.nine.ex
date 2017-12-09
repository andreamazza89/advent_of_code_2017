defmodule Year2017.Nine do

  @close_group 125
  @garbage_pattern ~r/<[^>]*>/
  @open_group 123

  def part_one(characters) do
    characters
      |> remove_ignorables
      |> clean_garbage
      |> String.to_charlist
      |> score
  end

  def part_two(characters) do
    characters
      |> remove_ignorables
      |> keep_garbage
      |> Enum.map(fn(garbage) -> String.length(List.first(garbage))-2 end)
      |> Enum.sum
  end

  def score(characters) do
    do_score(characters, 0, 0)
  end

  def do_score([], _, total_score) do
    total_score
  end

  def do_score(characters, score_per_group, total_score) do
    {group_boundary, characters_left} = find_group_boundary(characters)
    case group_boundary do
      @open_group ->
        do_score(characters_left, score_per_group + 1, total_score)
      @close_group ->
        do_score(characters_left, score_per_group - 1, total_score + score_per_group)
    end
  end

  def find_group_boundary(characters) do
    index_of_group_boundary = characters
      |> Enum.find_index(&(&1 == @open_group || &1 == @close_group))
    {Enum.at(characters, index_of_group_boundary), Enum.drop(characters, index_of_group_boundary + 1)}
  end

  def remove_ignorables(characters) do
    String.replace(characters, ~r/\!./, "")
  end

  def clean_garbage(characters) do
    String.replace(characters, @garbage_pattern, "")
  end

  def keep_garbage(characters) do
    Regex.scan(@garbage_pattern, characters)
  end

end
