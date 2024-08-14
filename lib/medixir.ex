defmodule Medixir do
  @moduledoc """
  Documentation for `Medixir`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Medixir.hello()
      :world

  """
  def hello do
    :world
  end

  # def nth(enum, n, med) do
  #   cond do
  #     (chunks[{true, false}] |> length) < n -> nth(chunks[{true,false}], n)
  #     ((chunks[{true, false}] ++ chunks[{false, false}]) |> length) <= n -> med
  #     true -> nth(chunks[{false, true}], n - length(chunks[{true, false}] ++ chunks[{false, false}]))
  #   end
  # end

  # def nth2(merged, med) do
  #   allvalues = merged |> Map.values |> List.flatten
  #   cond do
  #     (merged[{true, false}] |> length) < length(allvalues) -> med(merged[{true,false}])
  #     ((merged[{true, false}] ++ merged[{false, false}]) |> length) <= length(allvalues) -> med
  #     true -> nth(merged[{false, true}], n - length(merged[{true, false}] ++ merged[{false, false}]))
  #   end
  # end

  def groups(enum, n), do: enum |> Enum.group_by(&{&1 < n, &1 > n})

  def mergetwo(enum), do: mergetwo(enum, %{})
  def mergetwo([], finishedmap), do: finishedmap

  def mergetwo([a | tail], finishedmap),
    do: mergetwo(tail, Map.merge(finishedmap, a, fn _k, v1, v2 -> v1 ++ v2 end))

  def sortchunks(enum, n), do: enum |> Stream.chunk_every(n) |> Enum.map(&Enum.sort/1)


  def find(enum, pivot, n) when length(enum) > 0 do
    groups = enum |> groups(pivot)

    case groups do
      %{{true,false} => less} when n < length(less) -> find(less, chapu(less), n)
      %{{false,true} => more} when (length(enum) - length(more)) <= n -> find(more, chapu(more), n-(length(enum) - length(more)))
      _ -> pivot
    end
  end

  def middle(enum), do: Enum.at(enum, div(length(enum), 2))

  def chapu(enum) when length(enum) <= 5, do: enum |> middle


  def chapu(enum) do
    neco = enum |> sortchunks(5) |> Enum.map(&middle(&1))
    med = neco |> chapu
    neco |> find(med, middle(enum))
  end

  # def med(enum) do
  #   sorted_chunks =
  #     enum
  #     |> Stream.chunk_every(5)
  #     |> Enum.map(&Enum.sort/1)

  #   med = sorted_chunks |> Enum.map(&Enum.at(&1, 2)) |> med
  #   merged_chunks = sorted_chunks |> Enum.map(&groups(&1, med)) |> mergetwo
  #   nth = merged_chunks |> nth2(med)
  #   {merged_chunks, med}
  # end
end
