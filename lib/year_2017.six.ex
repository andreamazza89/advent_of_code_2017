defmodule Year2017.Six do

  def part_one(banks) do
    banks_seen = [banks]
    do_part_one(%{ banks_seen: banks_seen, current_banks: banks })
  end

  def do_part_one(state) do
    new_state = redistribute state

    if Enum.any?(state.banks_seen, &(&1 == new_state.current_banks)) do
      length(state.banks_seen)
    else
      do_part_one(%{ new_state |
        banks_seen: state.banks_seen ++ [new_state.current_banks] })
    end
  end

  def part_two(banks) do
    banks_seen = [banks]
    do_part_two(%{ banks_seen: banks_seen, current_banks: banks })
  end

  def do_part_two(state) do
    new_state = redistribute state

    if Enum.any?(state.banks_seen, &(&1 == new_state.current_banks)) do
      Enum.drop_while(state.banks_seen, &(&1 != new_state.current_banks))
        |> length
    else
      do_part_two(%{ new_state |
        banks_seen: state.banks_seen ++ [new_state.current_banks] })
    end
  end

  def redistribute(state) do
    left_to_distribute = Enum.max(state.current_banks)
    start_from = Enum.find_index(state.current_banks, &(&1 == left_to_distribute))
    new_state = %{ state | current_banks: List.replace_at(state.current_banks, start_from, 0) }
    do_redistribute(new_state, left_to_distribute, rem(start_from+1, length(state.current_banks)))
  end

  def do_redistribute(state, left_to_distribute, pointer) do
    if left_to_distribute == 0 do
      state
    else
      new_state = %{ state | current_banks: List.replace_at(state.current_banks, pointer, (Enum.at(state.current_banks, pointer) + 1)) }
      new_pointer = rem(pointer+1, length(state.current_banks))
      do_redistribute(new_state, left_to_distribute-1, new_pointer)
    end
  end
end
