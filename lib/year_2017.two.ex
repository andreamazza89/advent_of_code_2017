defmodule Year2017.Two do

  def part_one(raw_spreadsheet) do
    raw_spreadsheet
      |> process_spreadsheet_into_rows_of_integers
      |> Enum.map(fn(row) -> (Enum.max(row)) - (Enum.min(row)) end)
      |> Enum.sum
  end

  def part_two(raw_spreadsheet) do
    raw_spreadsheet
      |> process_spreadsheet_into_rows_of_integers
      |> Enum.flat_map(&find_evenly_divisible_pair/1)
      |> Enum.map(fn({a, b}) -> div(a, b) end)
      |> Enum.sum
  end

  defp process_spreadsheet_into_rows_of_integers(raw_spreadsheet) do
    raw_spreadsheet
      |> String.split("\n", trim: true)
      |> Enum.map(fn(row) -> String.split(row, " ", trim: true) end)
      |> Enum.map(fn(row) -> Enum.map(row, &String.to_integer/1) end)
  end

  defp find_evenly_divisible_pair(row) do
    evenly_divisible? = fn(a, b) -> rem(a, b) == 0 end
    different? = fn(a, b) -> a != b end
    for a <- row,
        b <- row,
        evenly_divisible?.(a,b),
        different?.(a,b),
        do: {a, b}
  end

end
