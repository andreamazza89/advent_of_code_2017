defmodule Year2017Test.Seven do
  use ExUnit.Case

  import Year2017.Seven

  test "finds the tip of iceberg" do
    result = "pbga (66)
    xhth (57)
    ebii (61)
    havc (66)
    ktlj (57)
    fwft (72) -> ktlj, cntj, xhth
    qoyq (66)
    padx (45) -> pbga, havc, qoyq
    tknk (41) -> ugml, padx, fwft
    jptl (61)
    ugml (68) -> gyxo, ebii, jptl
    gyxo (61)
    cntj (57)"
      |> find_root

    assert result == "tknk"
  end

  test "parses nodes" do
    result = "pbga (66)
    xhth (57)
    fwft (72) -> ktlj, cntj, xhth"
      |> parse_tree

    assert result == %{
      pbga: %{ children: [], weight: 66 },
      xhth: %{ children: [], weight: 57 },
      fwft: %{ children: [:ktlj, :cntj, :xhth], weight: 72 }
    }
  end

  test "computes a node's weight (node has no children)" do
    result = %{ node_a: %{ children: [], weight: 42 } }
      |> calculate_total_node_weight(:node_a)

    assert result == 42
  end

  test "computes a node's weight (node has children)" do
    result = %{
      node_a: %{ children: [:node_b, :node_c], weight: 10 },
      node_b: %{ children: [:node_d], weight: 10 },
      node_c: %{ children: [], weight: 10 },
      node_d: %{ children: [], weight: 10 },
    }
      |> calculate_total_node_weight(:node_a)

    assert result == 40
  end

  test "solves part one" do
    IO.puts "solution to day 7 part one"
    File.read!('./lib/inputs/Seven.input')
      |> find_root
      |> IO.inspect
  end

  test "finds an unbalanced node" do
  end

  test "solves part two" do
    IO.puts "\nsolution to day 7 part two"
    input = File.read!('./lib/inputs/Seven.input')
    tree = input
      |> parse_tree
    root = input
      |> find_root
    tree
      |> find_unbalanced(String.to_atom(root), [])
      |> IO.inspect
    IO.puts ""
  end

end
