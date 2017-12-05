defmodule Year2017.Five do

  def jump(state = %{ instructions: instructions,
                      cursor: cursor,
                      jumps_made: jumps_made }) do
    %{ state |
         instructions: update_instructions(instructions, cursor),
         cursor: update_current_instruction(instructions, cursor),
         jumps_made: jumps_made + 1 }
  end

  def jump_two(state = %{ instructions: instructions,
													cursor: cursor,
													jumps_made: jumps_made }) do
    %{ state |
         instructions: update_instructions_part_two(instructions, cursor),
         cursor: update_current_instruction(instructions, cursor),
         jumps_made: jumps_made + 1 }
  end

  defp update_instructions(instructions, cursor) do
    new_instruction = Enum.at(instructions, cursor) + 1
  	instructions
			|> List.replace_at(cursor, new_instruction)
  end

  defp update_instructions_part_two(instructions, cursor) do
		current_instruction_value = Enum.at(instructions, cursor)
		new_instruction = if (current_instruction_value >= 3) do
			current_instruction_value - 1
		else
			current_instruction_value + 1
		end
  	instructions
			|> List.replace_at(cursor, new_instruction)
  end

	defp update_current_instruction(instructions, cursor) do
		cursor + Enum.at(instructions, cursor)
	end

  def part_one(instructions) do
    initial_state = %{ instructions: instructions,
                       cursor: 0,
                       jumps_made: 0 }
    do_part_one(initial_state)
  end

  def do_part_one(state = %{ instructions: instructions,
                      cursor: cursor,
                      jumps_made: jumps_made }) do
    if (cursor >= length(instructions)) do
  		jumps_made
    else
			do_part_one(jump(state))
    end
  end

  def part_two(instructions) do
    initial_state = %{ instructions: instructions,
                       cursor: 0,
                       jumps_made: 0 }
    do_part_two(initial_state)
  end

  def do_part_two(state = %{ instructions: instructions,
														 cursor: cursor,
														 jumps_made: jumps_made }) do
    if (cursor >= length(instructions)) do
  		jumps_made
    else
			do_part_two(jump_two(state))
    end
  end

end
