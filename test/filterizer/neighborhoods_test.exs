defmodule Filterizer.NeighborhoodsTest do
  use Filterizer.DataCase

  alias Filterizer.Neighborhoods

  describe "neighborhoods" do
    alias Filterizer.Neighborhoods.Neighborhood

    import Filterizer.NeighborhoodsFixtures

    @invalid_attrs %{name: nil}

    test "list_neighborhoods/0 returns all neighborhoods" do
      neighborhood = neighborhood_fixture()
      assert Neighborhoods.list_neighborhoods() == [neighborhood]
    end

    test "get_neighborhood!/1 returns the neighborhood with given id" do
      neighborhood = neighborhood_fixture()
      assert Neighborhoods.get_neighborhood!(neighborhood.id) == neighborhood
    end

    test "create_neighborhood/1 with valid data creates a neighborhood" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Neighborhood{} = neighborhood} = Neighborhoods.create_neighborhood(valid_attrs)
      assert neighborhood.name == "some name"
    end

    test "create_neighborhood/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Neighborhoods.create_neighborhood(@invalid_attrs)
    end

    test "update_neighborhood/2 with valid data updates the neighborhood" do
      neighborhood = neighborhood_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Neighborhood{} = neighborhood} = Neighborhoods.update_neighborhood(neighborhood, update_attrs)
      assert neighborhood.name == "some updated name"
    end

    test "update_neighborhood/2 with invalid data returns error changeset" do
      neighborhood = neighborhood_fixture()
      assert {:error, %Ecto.Changeset{}} = Neighborhoods.update_neighborhood(neighborhood, @invalid_attrs)
      assert neighborhood == Neighborhoods.get_neighborhood!(neighborhood.id)
    end

    test "delete_neighborhood/1 deletes the neighborhood" do
      neighborhood = neighborhood_fixture()
      assert {:ok, %Neighborhood{}} = Neighborhoods.delete_neighborhood(neighborhood)
      assert_raise Ecto.NoResultsError, fn -> Neighborhoods.get_neighborhood!(neighborhood.id) end
    end

    test "change_neighborhood/1 returns a neighborhood changeset" do
      neighborhood = neighborhood_fixture()
      assert %Ecto.Changeset{} = Neighborhoods.change_neighborhood(neighborhood)
    end
  end
end
