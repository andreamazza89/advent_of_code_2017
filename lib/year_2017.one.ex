defmodule Year2017.One do

  def readInput do
    list = File.read!('./lib/inputs/One.input')
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def count(numbers, steps) do
    rotated = rotate(numbers, steps)

    Enum.zip(numbers, rotated)
      |> Enum.filter(fn ({a, b}) -> a == b end)
      |> Enum.reduce(0, fn ({a, _}, total) -> total + a end)
  end

  defp rotate(enumerable, steps) do
    {afterr, before} = Enum.split(enumerable, steps)
    before ++ afterr
  end

end
