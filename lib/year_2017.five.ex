defmodule Year2017.Five do

  def jump(state = %{ instructions: instructions,
                      current_instruction: current_instruction,
                      jumps_made: jumps_made }) do
    %{ state |
         instructions: update_instructions(instructions, current_instruction),
         current_instruction: update_current_instruction(instructions, current_instruction),
         jumps_made: jumps_made + 1 }
  end

  defp update_instructions(instructions, current_instruction) do
    new_instruction = Enum.at(instructions, current_instruction) + 1
  	instructions
			|> List.replace_at(current_instruction, new_instruction)
  end

	defp update_current_instruction(instructions, current_instruction) do
		current_instruction + Enum.at(instructions, current_instruction)
	end

  def part_one(instructions) do
    initial_state = %{ instructions: instructions,
                       current_instruction: 0,
                       jumps_made: 0 }
    do_part_one(initial_state)
  end

  def do_part_one(state = %{ instructions: instructions,
                      current_instruction: current_instruction,
                      jumps_made: jumps_made }) do
    if (current_instruction >= length(instructions)) do
  		jumps_made
    else
			do_part_one(jump(state))
    end
  end

end
