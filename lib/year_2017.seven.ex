defmodule Year2017.Seven do

  def find_root(raw_relations) do
    nodes = raw_relations
      |> String.split
      |> Enum.filter(&(String.match?(&1, ~r/[a-z]/)))
      |> Enum.map(&(String.replace(&1, ",", "")))

    nodes
      |> Enum.group_by(fn(node) -> Enum.count(nodes, &(&1 == node)) end)
      |> Map.get(1)
      |> Enum.at(0)
  end

  def parse_tree(raw_relations) do
    raw_relations
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, &Year2017.Seven.parse_node/2)
  end

  def parse_node(raw_node, tree) do
    children = extract_children_from_raw_node(raw_node)
    node_name_and_weight = Regex.named_captures(~r/(?<node_name>\w+) \((?<weight>\d+)\)/, raw_node)
    node_name = String.to_atom(node_name_and_weight["node_name"])
    node_weight = String.to_integer(node_name_and_weight["weight"])

    Map.put(tree, node_name, %{children: children, weight: node_weight})
  end

  def calculate_total_node_weight(tree, node) do
    children_weights = tree[node].children
      |> Enum.map(fn(n) -> calculate_total_node_weight(tree, n) end)

    tree[node].weight + Enum.sum(children_weights)
  end

  def find_unbalanced(tree, node_id, sibilings) do
    children_ids = tree[node_id].children
    children_ids_and_weights = children_ids
      |> Enum.map(id_to_id_and_weight(tree))

    if children_are_balanced(children_ids_and_weights) do
      {tree[node_id], Enum.map(sibilings, &(calculate_total_node_weight(tree, &1)))}
    else
      find_unbalanced(tree, unbalanced_child_id(children_ids_and_weights), children_ids)
    end
  end

  defp id_to_id_and_weight(tree) do
    fn(id) -> {id, calculate_total_node_weight(tree, id)} end
  end

  defp children_are_balanced(children_ids_and_weights) do
    unique_weights = children_ids_and_weights
      |> Enum.map(fn({id, weight}) -> weight end)
      |> Enum.uniq

    length(unique_weights) <= 1
  end

  defp unbalanced_child_id(children_ids_and_weights) do
    children_ids_and_weights
      |> Enum.group_by(fn({this_id, this_weight}) ->
        Enum.count(children_ids_and_weights, fn({id, weight}) -> weight == this_weight end)
      end, fn({id, weight}) -> id end)
      |> Map.get(1)
      |> Enum.at(0)
  end

  defp extract_children_from_raw_node(raw_node) do
    raw_node
      |> String.replace(~r/\w+ \(\d+\)( -> )?/, "")
      |> String.replace(",", "")
      |> String.split
      |> Enum.map(&String.to_atom/1)
  end


end
