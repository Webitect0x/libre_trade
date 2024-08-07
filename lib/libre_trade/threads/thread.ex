defmodule LibreTrade.Threads.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  alias LibreTrade.Posts.Post

  schema "threads" do
    field :name, :string
    field :description, :string
    field :subscribers, :integer, default: 0
    field :logo, :string

    has_many :posts, Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:name, :description, :logo, :subscribers])
    |> update_change(:name, &String.downcase/1)
    |> unique_constraint(:name)
    |> validate_required([:name, :description, :subscribers])
  end
end
