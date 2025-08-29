defmodule Filterizer.NeighborhoodsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Filterizer.Neighborhoods` context.
  """

  @doc """
  Generate a neighborhood.
  """
  def neighborhood_fixture(attrs \\ %{}) do
    {:ok, neighborhood} =
      attrs
      |> Enum.into(%{
        name: "Chelsea"
      })
      |> Filterizer.Neighborhoods.create_neighborhood()

    neighborhood
  end
end
