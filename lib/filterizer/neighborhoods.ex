defmodule Filterizer.Neighborhoods do
  @moduledoc """
  The Neighborhoods context.
  """

  import Ecto.Query, warn: false
  alias Filterizer.Repo

  alias Filterizer.Neighborhoods.Neighborhood

  @doc """
  Returns the list of neighborhoods.

  ## Examples

      iex> list_neighborhoods()
      [%Neighborhood{}, ...]

  """
  def list_neighborhoods do
    Repo.all(Neighborhood)
  end

  @doc """
  Gets a single neighborhood.

  Raises `Ecto.NoResultsError` if the Neighborhood does not exist.

  ## Examples

      iex> get_neighborhood!(123)
      %Neighborhood{}

      iex> get_neighborhood!(456)
      ** (Ecto.NoResultsError)

  """
  def get_neighborhood!(id), do: Repo.get!(Neighborhood, id)

  @doc """
  Creates a neighborhood.

  ## Examples

      iex> create_neighborhood(%{field: value})
      {:ok, %Neighborhood{}}

      iex> create_neighborhood(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_neighborhood(attrs) do
    %Neighborhood{}
    |> Neighborhood.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a neighborhood.

  ## Examples

      iex> update_neighborhood(neighborhood, %{field: new_value})
      {:ok, %Neighborhood{}}

      iex> update_neighborhood(neighborhood, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_neighborhood(%Neighborhood{} = neighborhood, attrs) do
    neighborhood
    |> Neighborhood.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a neighborhood.

  ## Examples

      iex> delete_neighborhood(neighborhood)
      {:ok, %Neighborhood{}}

      iex> delete_neighborhood(neighborhood)
      {:error, %Ecto.Changeset{}}

  """
  def delete_neighborhood(%Neighborhood{} = neighborhood) do
    Repo.delete(neighborhood)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking neighborhood changes.

  ## Examples

      iex> change_neighborhood(neighborhood)
      %Ecto.Changeset{data: %Neighborhood{}}

  """
  def change_neighborhood(%Neighborhood{} = neighborhood, attrs \\ %{}) do
    Neighborhood.changeset(neighborhood, attrs)
  end
end
