defmodule LibreTrade.Posts.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias LibreTrade.Posts.Post
  alias LibreTrade.Accounts.User

  schema "comments" do
    field :content, :string

    belongs_to :post, Post
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :post_id, :user_id])
    |> validate_required([:content, :post_id, :user_id])
  end
end
