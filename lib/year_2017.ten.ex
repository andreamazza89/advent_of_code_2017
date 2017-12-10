defmodule Year2017.Ten do
  use Bitwise

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

  def part_two(lengths) do
    decimal_to_hex_string = fn(n) -> Integer.to_string(n, 16) end
    pad_hex_with_zero = fn(hex_string) -> String.pad_leading(hex_string, 2, "0") end
    sparse_hash(Enum.to_list(0..255), 0, 0, 63, lengths, lengths)
      |> Enum.chunk_every(16)
      |> Enum.map(&densify/1)
      |> Enum.map(decimal_to_hex_string)
      |> Enum.map(pad_hex_with_zero)
      |> Enum.join
      |> String.downcase
  end

  def sparse_hash(list, _, _, 0, [], _) do
    list
  end

  def sparse_hash(list, current_position, skip_size, rounds_remaining, [], original_lengths) do
    sparse_hash(list, current_position, skip_size, rounds_remaining - 1, original_lengths, original_lengths)
  end

  def sparse_hash(list, current_position, skip_size, rounds_remaining, [ first_length | rest_lengths ], original_lengths) do
    new_list = wrap_reverse(list, current_position, first_length)
    new_position = rem(current_position + first_length + skip_size, length(list))
    new_skip_size = skip_size + 1

    sparse_hash(new_list, new_position, new_skip_size, rounds_remaining, rest_lengths, original_lengths)
  end

  def wrap_reverse(list, current_position, sublist_size) do
    list_starting_with_current_position = rotate(list, current_position)

    untouched = Enum.drop(list_starting_with_current_position, sublist_size)
    reversed = Enum.take(list_starting_with_current_position, sublist_size)
      |> Enum.reverse

    derotate(reversed ++ untouched, current_position)
  end

  def densify(block) do
    block
      |> Enum.reduce(0, fn(x, acc) -> x ^^^ acc end)
  end

  defp rotate(list, current_position) do
    {afterr, before} = Enum.split(list, current_position)
    before ++ afterr
  end

  defp derotate(list, current_position) do
    {afterr, before} = Enum.split(list, length(list) - current_position)
    before ++ afterr
  end

end
