defmodule LibreTrade.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias LibreTrade.Accounts.User
  alias LibreTrade.Threads.Thread
  alias LibreTrade.Posts.Comment

  schema "posts" do
    field :title, :string
    field :content, :string
    field :upvotes, :integer, default: 0

    belongs_to :user, User
    belongs_to :thread, Thread

    has_many :comments, Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :upvotes, :user_id, :thread_id])
    |> validate_required([:title, :content, :user_id, :thread_id])
  end
end
