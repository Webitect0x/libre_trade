defmodule LibreTrade.Threads.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias LibreTrade.Accounts.User
  alias LibreTrade.Threads.Thread

  schema "posts" do
    field :title, :string
    field :content, :string

    belongs_to :user, User
    belongs_to :thread, Thread

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :user_id, :thread_id])
    |> validate_required([:title, :content, :user_id, :thread_id])
  end
end
