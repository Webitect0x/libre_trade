defmodule LibreTrade.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :subscriber_id, references(:users, on_delete: :nothing)
      add :thread_id, references(:threads, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:subscriptions, [:subscriber_id])
    create index(:subscriptions, [:thread_id])
    create unique_index(:subscriptions, [:subscriber_id, :thread_id])
  end
end
