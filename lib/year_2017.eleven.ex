defmodule Year2017.Eleven do
  # using a coordinate system where x grows to the right and y downwards,
  # as seen here: https://www.redblobgames.com/grids/hexagons/

  def part_one(coordinates) do
    coordinates
      |> String.split(",", trim: true)
      |> do_part_one({0,0}, 0)
  end

  def do_part_one([], end_coordinates, furthest) do
    [
      {:part_one, shortest_path_via_diagonal(end_coordinates)},
      {:part_two, furthest}
    ]
  end

  def do_part_one([first_direction | rest_directions], current_coordinates, furthest) do
    new_coordinates = move(current_coordinates, first_direction)
    new_furthest = Enum.max([furthest, shortest_path_via_diagonal(new_coordinates)])
    do_part_one(rest_directions, new_coordinates, new_furthest)
  end


  def move({from_x, from_y}, "n") do
    {from_x, from_y - 1}
  end

  def move({from_x, from_y}, "ne") do
    {from_x + 1, from_y - 1}
  end

  def move({from_x, from_y}, "se") do
    {from_x + 1, from_y}
  end

  def move({from_x, from_y}, "s") do
    {from_x, from_y + 1}
  end

  def move({from_x, from_y}, "sw") do
    {from_x - 1, from_y + 1}
  end

  def move({from_x, from_y}, "nw") do
    {from_x - 1, from_y}
  end

  def shortest_path_via_diagonal({x,y}) do
    [ abs(x) + abs(y),
      abs(x+y) + abs(x),
      abs(x+y) + abs(y) ]
      |> Enum.min
  end

end
