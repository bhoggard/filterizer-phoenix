defmodule Filterizer.Repo.Migrations.CreateNeighborhoods do
  use Ecto.Migration

  def change do
    create table(:neighborhoods) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
    create unique_index(:neighborhoods, [:name])
  end
end
