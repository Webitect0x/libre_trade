defmodule LibreTrade.Threads.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  alias LibreTrade.Accounts.User
  alias LibreTrade.Threads.Thread

  schema "subscriptions" do
    belongs_to :subscriber, User
    belongs_to :thread, Thread

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:subscriber_id, :thread_id])
    |> validate_required([:subscriber_id, :thread_id])
    |> unique_constraint([:subscriber_id, :thread_id])
  end
end
