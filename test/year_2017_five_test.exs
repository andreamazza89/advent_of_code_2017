defmodule Year2017Test.Five do
  use ExUnit.Case

  test "jumps to the next position based on the current instruction" do
    result = %{ instructions: [0, 3, 0, 1, -3],
                cursor: 1,
                jumps_made: 0 }
      |> Year2017.Five.jump
    assert result.cursor == 4
  end

  test "updates the count of jumps made every jump" do
    result = %{ instructions: [0, 3, 0, 1, -3],
                cursor: 1,
                jumps_made: 0 }
      |> Year2017.Five.jump
    assert result.jumps_made == 1
  end

  test "adds one to the offset of an instruction when it visits it" do
    result = %{ instructions: [0, 3, 0, 1, -3],
                cursor: 1,
                jumps_made: 0 }
      |> Year2017.Five.jump
    assert result.instructions == [0, 4, 0, 1, -3]
  end

  test "(part two) decreases one to the offset of an instruction if it's 3 or more" do
    result = %{ instructions: [0, 3, 0, 1, -3],
                cursor: 1,
                jumps_made: 0 }
      |> Year2017.Five.jump_two
    assert result.instructions == [0, 2, 0, 1, -3]
  end

  test "(part two) increases one to the offset of an instruction if it's less than 3" do
    result = %{ instructions: [0, 3, 0, 1, -3],
                cursor: 2,
                jumps_made: 0 }
      |> Year2017.Five.jump_two
    assert result.instructions == [0, 3, 1, 1, -3]
  end

 # test "solves part one" do
 #   IO.puts "solution to day 5 part one:"
 #   File.read!('./lib/inputs/Five.input')
 #     |> String.split("\n", trim: true)
 #     |> Enum.map(&String.to_integer/1)
 #     |> Year2017.Five.part_one
 #     |> IO.inspect
 # end

 #test "solves part two" do
 #  IO.puts "solution to day 5 part two:"
 #  File.read!('./lib/inputs/Five.input')
 #    |> String.split("\n", trim: true)
 #    |> Enum.map(&String.to_integer/1)
 #    |> Year2017.Five.part_two
 #    |> IO.inspect
 #end

end
