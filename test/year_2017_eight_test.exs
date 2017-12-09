defmodule Year2017Test.Eight do
  use ExUnit.Case

  alias Year2017.Eight.Predicate, as: Predicate
  alias Year2017.Eight.State, as: State

  import Year2017.Eight

  test "increase instruction with true predicate" do
    predicate = %Predicate{ left: :a, right: 0, comparison: &==/2 }
    inc_instruction = new_increase_instruction(42, :a, predicate)
    initial_state = %State{ cursor: 0 }

    updated_state = inc_instruction.(initial_state)

    assert get_register(updated_state.registers, :a) == 42
    assert updated_state.cursor == 1
  end

  test "increase instruction with false predicate" do
    registers = %{ a: 42 }
    predicate = %Predicate{ left: :a, right: 10, comparison: &==/2 }
    inc_instruction = new_increase_instruction(2, :a, predicate)
    initial_state = %State{ cursor: 0, registers: registers }

    updated_state = inc_instruction.(initial_state)

    assert get_register(updated_state.registers, :a) == 42
    assert updated_state.cursor == 1
  end

  test "decrease instruction with true predicate" do
    predicate = %Predicate{ left: :a, right: 0, comparison: &==/2 }
    dec_instruction = new_decrease_instruction(10, :a, predicate)
    initial_state = %State{ cursor: 0 }

    updated_state = dec_instruction.(initial_state)

    assert get_register(updated_state.registers, :a) == -10
    assert updated_state.cursor == 1
  end

  test "decrease instruction with false predicate" do
    registers = %{ a: 42 }
    predicate = %Predicate{ left: :a, right: 10, comparison: &==/2 }
    dec_instruction = new_decrease_instruction(2, :a, predicate)
    initial_state = %State{ cursor: 0, registers: registers }

    updated_state = dec_instruction.(initial_state)

    assert get_register(updated_state.registers, :a) == 42
    assert updated_state.cursor == 1
  end

  test "parses an increase instruction" do
    instruction = "b inc 5 if a > 1"
      |> parse_instruction

    expected_predicate = %Predicate{ left: :a, right: 1, comparison: &>/2 }
    assert instruction == new_increase_instruction(5, :b, expected_predicate)
  end

  test "parses a decrease instruction" do
    instruction = "b dec 5 if a > -1"
      |> parse_instruction

    expected_predicate = %Predicate{ left: :a, right: -1, comparison: &>/2 }
    assert instruction == new_decrease_instruction(5, :b, expected_predicate)
  end

  test "increase instruction udpates the highest register value" do
    registers = %{ a: 40 }
    predicate = %Predicate{ left: :a, right: 40, comparison: &==/2 }
    inc_instruction = new_increase_instruction(2, :a, predicate)
    initial_state = %State{ highest_register: 40, registers: registers }

    updated_state = inc_instruction.(initial_state)

    assert updated_state.highest_register == 42
  end

  test "solves part one and two" do
    IO.puts "solution to day 8 part one"
    File.read!('./lib/inputs/Eight.input')
      |> part_one
      |> IO.inspect
  end

end
