defmodule Year2017.Three do

  defmodule PositionInSpiral do
    @enforce_keys [:content, :coordinates]
    defstruct [:content, :coordinates]
  end

  defmodule World do
    defstruct direction: "RIGHT",
              positions_in_spiral: [%PositionInSpiral{content: 1, coordinates: %{x: 0, y: 0}}],
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


  def generate_new_position(world = %World{ direction: "DOWN" }) do
    latest_coordinates = latest_position(world).coordinates
    %PositionInSpiral{
      content: new_content(latest_position(world)),
      coordinates: %{latest_coordinates | y: (latest_coordinates.y - 1)}
    }
  end

  def generate_new_position(world = %World{ direction: "RIGHT" }) do
    latest_coordinates = latest_position(world).coordinates
    %PositionInSpiral{
      content: new_content(latest_position(world)),
      coordinates: %{latest_coordinates | x: (latest_coordinates.x + 1)}
    }
  end

  def generate_new_position(world = %World{ direction: "UP" }) do
    latest_coordinates = latest_position(world).coordinates
    %PositionInSpiral{
      content: new_content(latest_position(world)),
      coordinates: %{latest_coordinates | y: (latest_coordinates.y + 1)}
    }
  end

  def generate_new_position(world = %World{ direction: "LEFT" }) do
    latest_coordinates = latest_position(world).coordinates
    %PositionInSpiral{
     content: new_content(latest_position(world)),
      coordinates: %{latest_coordinates | x: (latest_coordinates.x - 1)}
    }
  end

  defp new_content(latest_position) do
    latest_position.content + 1
  end

end
