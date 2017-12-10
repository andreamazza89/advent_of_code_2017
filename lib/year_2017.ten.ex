defmodule Year2017.Ten do

  def part_one(lengths) do
    do_part_one(Enum.to_list(0..255), 0, 0, lengths)
      |> Enum.take(2)
      |> Enum.reduce(&*/2)
  end

  def do_part_one(list, _, _, []) do
    list
  end

  def do_part_one(list, current_position, skip_size, [ first_length | rest_lengths ]) do
    new_list = wrap_reverse(list, current_position, first_length)
    new_position = rem(current_position + first_length + skip_size, length(list))
    new_skip_size = skip_size + 1

    do_part_one(new_list, new_position, new_skip_size, rest_lengths)
  end

  def wrap_reverse(list, current_position, sublist_size) do
    list_starting_with_current_position = rotate(list, current_position)

    untouched = Enum.drop(list_starting_with_current_position, sublist_size)
    reversed = Enum.take(list_starting_with_current_position, sublist_size)
      |> Enum.reverse

    derotate(reversed ++ untouched, current_position)
  end

  def rotate(list, current_position) do
    {afterr, before} = Enum.split(list, current_position)
    before ++ afterr
  end

  def derotate(list, current_position) do
    {afterr, before} = Enum.split(list, length(list) - current_position)
    before ++ afterr
  end

end
