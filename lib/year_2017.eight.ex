defmodule Year2017.Eight do

  defmodule Predicate do
    defstruct [:left, :right, :comparison]
  end

  defmodule State do
    defstruct cursor: 0, registers: %{}, highest_register: 0
  end

  @instruction_pattern ~r/^(?<target>\w+) (?<instruction_type>\w+) (?<delta>(-)?\d+) if (?<predicate_left>\w+) (?<predicate_comparison>.+) (?<predicate_right>(-)?\d+)/

  def part_one(raw_instructions) do
    final_state = raw_instructions
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_instruction/1)
      |> Enum.reduce(%State{}, fn(instruction, state) -> instruction.(state) end)

    highest_register = final_state
      |> Map.get(:registers)
      |> Enum.max_by(fn({_register_name, content}) -> content end)

    highest_register_ever = final_state
      |> Map.get(:highest_register)

    {highest_register, highest_register_ever}
  end

  def parse_instruction(raw_instruction) do
    case instruction_type(raw_instruction) do
      :increase ->
        new_increase_instruction(
          delta(raw_instruction),
          target(raw_instruction),
          predicate(raw_instruction)
        )
      :decrease ->
        new_decrease_instruction(
          delta(raw_instruction),
          target(raw_instruction),
          predicate(raw_instruction)
        )
      _ ->
        raise "instruction parsing failed"
    end
  end

  defp instruction_type(raw_instruction) do
    case Regex.named_captures(@instruction_pattern, raw_instruction)["instruction_type"] do
      "inc" ->
        :increase
      "dec" ->
        :decrease
      _ ->
        raise "unsupported instruction type"
    end
  end

  defp delta(raw_instruction) do
    Regex.named_captures(@instruction_pattern, raw_instruction)["delta"]
      |> String.to_integer
  end

  defp target(raw_instruction) do
    Regex.named_captures(@instruction_pattern, raw_instruction)["target"]
      |> String.to_atom
  end

  defp predicate(raw_instruction) do
    instruction_info = Regex.named_captures(@instruction_pattern, raw_instruction)
    left = String.to_atom(instruction_info["predicate_left"])
    right = String.to_integer(instruction_info["predicate_right"])
    comparison = case instruction_info["predicate_comparison"] do
      "==" ->
        &==/2
      "!=" ->
        &!=/2
      ">" ->
        &>/2
      ">=" ->
        &>=/2
      "<" ->
        &</2
      "<=" ->
        &<=/2
      _ ->
        raise "unsupported predicate comparison"
    end

    %Predicate{ left: left, right: right, comparison: comparison }
  end

  def new_increase_instruction(increase_by, register_id, predicate) do
    fn(state) ->
      new_cursor = state.cursor + 1

      if predicate_true?(predicate, state) do
        new_registers = increase_register(state.registers, register_id, increase_by)
        new_highest = Enum.max([state.highest_register, get_register(new_registers, register_id)])
        %State{ state | cursor: new_cursor, highest_register: new_highest, registers: new_registers }
      else
        %State{ state | cursor: new_cursor }
      end
    end
  end

  def new_decrease_instruction(decrease_by, register_id, predicate) do
    new_increase_instruction(-decrease_by, register_id, predicate)
  end

  defp predicate_true?(predicate, state) do
    left_value = get_register(state.registers, predicate.left)
    right_value = predicate.right
    apply(predicate.comparison, [left_value, right_value])
  end

  defp increase_register(registers, register_id, increase_by) do
    new_register_value = get_register(registers, register_id) + increase_by
    set_register(registers, register_id, new_register_value)
  end

  def get_register(registers, register_id) do
    Map.get(registers, register_id, 0)
  end

  def set_register(registers, register_id, new_value) do
    Map.put(registers, register_id, new_value)
  end

end
