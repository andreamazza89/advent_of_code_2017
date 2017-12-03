#should have used parametrized tests!

defmodule Year2017Test.Three do
  use ExUnit.Case

  alias Year2017.Three.PositionInSpiral, as: Position
  alias Year2017.Three.World, as: World

  import Year2017.Three

  test "updates the direction DOWN->RIGHT when it runs out of steps in the current direction" do
    result = update_world(%{ %World{} | direction: "DOWN", steps_left: 0 } )
    assert result.direction == "RIGHT"
  end

  test "updates the direction RIGHT->UP when it runs out of steps in the current direction" do
    result = update_world(%{ %World{} | direction: "RIGHT", steps_left: 0 } )
    assert result.direction == "UP"
  end

  test "updates the direction UP->LEFT when it runs out of steps in the current direction" do
    result = update_world(%{ %World{} | direction: "UP", steps_left: 0 } )
    assert result.direction == "LEFT"
  end

  test "updates the direction LEFT->DOWN when it runs out of steps in the current direction" do
    result = update_world(%{ %World{} | direction: "LEFT", steps_left: 0 } )
    assert result.direction == "DOWN"
  end

  test "does not update the direction if there are still steps left" do
    result = update_world(%{ %World{} | direction: "DOWN", steps_left: 3 } )
    assert result.direction == "DOWN"

    result = update_world(%{ %World{} | direction: "RIGHT", steps_left: 3 } )
    assert result.direction == "RIGHT"

    result = update_world(%{ %World{} | direction: "UP", steps_left: 3 } )
    assert result.direction == "UP"

    result = update_world(%{ %World{} | direction: "LEFT", steps_left: 3 } )
    assert result.direction == "LEFT"
  end

  test "updates steps_left (at least one left)" do
    result = update_world(%{ %World{} | direction: "DOWN", steps_left: 3 } )
    assert result.steps_left == 2

    result = update_world(%{ %World{} | direction: "RIGHT", steps_left: 3 } )
    assert result.steps_left == 2

    result = update_world(%{ %World{} | direction: "UP", steps_left: 3 } )
    assert result.steps_left == 2

    result = update_world(%{ %World{} | direction: "LEFT", steps_left: 3 } )
    assert result.steps_left == 2
  end

  test "when no steps are left, updates steps_left to the new step_count" do
    result = update_world(%{ %World{} | direction: "DOWN", steps_left: 0, steps_in_this_direction: 3 } )
    assert result.steps_left == 4
    assert result.steps_in_this_direction == 4

    result = update_world(%{ %World{} | direction: "RIGHT", steps_left: 0, steps_in_this_direction: 3 } )
    assert result.steps_left == 3
    assert result.steps_in_this_direction == 3


    result = update_world(%{ %World{} | direction: "UP", steps_left: 0, steps_in_this_direction: 3 } )
    assert result.steps_left == 4
    assert result.steps_in_this_direction == 4

    result = update_world(%{ %World{} | direction: "LEFT", steps_left: 0, steps_in_this_direction: 3 } )
    assert result.steps_left == 3
    assert result.steps_in_this_direction == 3
  end

  test "prepends the next position based on the direction" do
    updated1 = update_world(%World{
              direction: "RIGHT",
              positions_in_spiral: [%Position{content: 1, coordinates: %{x: 0, y: 0}}],
              steps_left: 0,
              steps_in_this_direction: 0
    })
    assert length(updated1.positions_in_spiral) == 2
    assert latest_position(updated1) == %Position{content: 2, coordinates: %{x: 1, y: 0}}


    updated2 = update_world(updated1)
    assert length(updated2.positions_in_spiral) == 3
    assert latest_position(updated2) == %Position{content: 3, coordinates: %{x: 1, y: 1}}

    updated3 = update_world(updated2)
    assert length(updated3.positions_in_spiral) == 4
    assert latest_position(updated3) == %Position{content: 4, coordinates: %{x: 0, y: 1}}

    updated4 = update_world(updated3)
    assert length(updated4.positions_in_spiral) == 5
    assert latest_position(updated4) == %Position{content: 5, coordinates: %{x: -1, y: 1}}

    updated5 = update_world(updated4)
    assert length(updated5.positions_in_spiral) == 6
    assert latest_position(updated5) == %Position{content: 6, coordinates: %{x: -1, y: 0}}
  end

  test "solves part one" do
    IO.puts "solution to day 3 part one:"
    part_one()
      |> IO.inspect
  end

  #test "solves part two" do
  #  IO.puts "solution to day 3 part two:"
  #  part_two()
  #    |> IO.inspect
  #end

end
