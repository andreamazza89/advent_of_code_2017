defmodule Year2017.Three do

  defmodule PositionInSpiral do
    defstruct content: 1,
              coordinates: %{x: 0, y: 0}
  end

  defmodule World do
    defstruct direction: "RIGHT",
              positions_in_spiral: [%PositionInSpiral{}],
              steps_left: 0,
              steps_in_this_direction: 0
  end

  def part_one() do
    target_position = Stream.iterate(%World{}, &update_world/1)
      |> Stream.take(361527)
      |> Enum.at(361526)
      |> latest_position

    target_position.coordinates.x + target_position.coordinates.y
  end

  def part_two() do
    target_position = Stream.iterate(%World{}, &update_world/1)
      |> Stream.take_while(fn(world) -> latest_position(world).content < 365000  end)
      |> Enum.to_list
      |> List.last
      |> latest_position
      |> Map.get(:content)
  end

  def latest_position(%World{positions_in_spiral: [first | _rest]}) do
    first
  end

  def add_position(world = %World{positions_in_spiral: positions}, new_position) do
    %World{world | positions_in_spiral: [new_position] ++ positions}
  end

  def update_world(world = %World{ direction: "DOWN", steps_left: steps_left })
  when (steps_left == 0) do
    new_step_count = world.steps_in_this_direction + 1
    %{ world | direction: "RIGHT",
               steps_left: new_step_count,
               steps_in_this_direction: new_step_count }
      |> add_position(generate_new_position(world))
  end

  def update_world(world = %World{ direction: "DOWN", steps_left: steps_left })
  when (steps_left > 0) do
    %{ world | steps_left: (steps_left - 1) }
      |> add_position(generate_new_position(world))
  end



  def update_world(world = %World{ direction: "RIGHT", steps_left: steps_left })
  when (steps_left == 0) do
    %{ world | direction: "UP",
               steps_left: world.steps_in_this_direction }
      |> add_position(generate_new_position(world))
  end

  def update_world(world = %World{ direction: "RIGHT", steps_left: steps_left })
  when (steps_left > 0) do
    %{ world | steps_left: (steps_left - 1) }
      |> add_position(generate_new_position(world))
  end



  def update_world(world = %World{ direction: "UP", steps_left: steps_left })
  when (steps_left == 0) do
    new_step_count = world.steps_in_this_direction + 1
    %{ world | direction: "LEFT",
               steps_left: new_step_count,
               steps_in_this_direction: new_step_count }
      |> add_position(generate_new_position(world))
  end

  def update_world(world = %World{ direction: "UP", steps_left: steps_left })
  when (steps_left > 0) do
    %{ world | steps_left: (steps_left - 1)  }
      |> add_position(generate_new_position(world))
  end



  def update_world(world = %World{ direction: "LEFT", steps_left: steps_left })
  when (steps_left == 0) do
    %{ world | direction: "DOWN",
               steps_left: world.steps_in_this_direction }
        |> add_position(generate_new_position(world))
  end

  def update_world(world = %World{ direction: "LEFT", steps_left: steps_left })
  when (steps_left > 0) do
    %{ world | steps_left: (steps_left - 1)  }
      |> add_position(generate_new_position(world))
  end



  def generate_new_position(world = %World{ direction: direction }) do
    new_coordinates = generate_new_coordinates(direction, latest_position(world).coordinates)
    %PositionInSpiral{
      content: new_content_part_one(world),
      coordinates: new_coordinates
    }
  end

  def generate_new_coordinates("DOWN", latest_coordinates) do
    %{latest_coordinates | y: (latest_coordinates.y - 1)}
  end

  def generate_new_coordinates("RIGHT", latest_coordinates) do
    %{latest_coordinates | x: (latest_coordinates.x + 1)}
  end

  def generate_new_coordinates("UP", latest_coordinates) do
    %{latest_coordinates | y: (latest_coordinates.y + 1)}
  end

  def generate_new_coordinates("LEFT", latest_coordinates) do
    %{latest_coordinates | x: (latest_coordinates.x - 1)}
  end

  defp new_content_part_one(world) do
    latest_position(world).content + 1
  end

  defp new_content_part_two(world, target_coordinates) do
    is_adjacent_to_new_position? = fn(this_position) ->
      these_coordinates = this_position.coordinates

      (abs(target_coordinates.x - these_coordinates.x) <= 1) &&
      (abs(target_coordinates.y - these_coordinates.y) <= 1)
    end

    world.positions_in_spiral
      |> Enum.filter(is_adjacent_to_new_position?)
      |> Enum.map(fn(position) -> position.content end)
      |> Enum.sum
  end

end
