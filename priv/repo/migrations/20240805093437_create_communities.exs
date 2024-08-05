defmodule LibreTrade.Repo.Migrations.CreateCommunities do
  use Ecto.Migration

  def change do
    create table(:communities) do
      add :name, :string
      add :description, :text
      add :logo, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:communities, [:name])
  end
end
