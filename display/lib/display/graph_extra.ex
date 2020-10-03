defmodule Display.GraphExtra do
  @moduledoc """
  GraphExtra holds functions with the intention of them being called from gleam.
  These functions help "lie" to the gleam compiler to make nice types
  """

  @doc """
  Called from gleam and used to turn any type into a GraphId.
  This lets trick gleam so we have types like Id(GraphId)
  that nicely map to {:id, id} shaped tuples.
  """
  @spec id(data :: any()) :: any()
  def id(data), do: data
end
