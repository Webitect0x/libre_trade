defmodule LibreTrade.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :name, :string
      add :description, :text
      add :logo, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:threads, [:name])
  end
end
