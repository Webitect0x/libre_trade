defmodule LibreTrade.Communities.Community do
  use Ecto.Schema
  import Ecto.Changeset

  schema "communities" do
    field :name, :string
    field :description, :string
    field :logo, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(community, attrs) do
    community
    |> cast(attrs, [:name, :description, :logo])
    |> update_change(:name, &String.capitalize(&1))
    |> unique_constraint(:name)
    |> validate_required([:name, :description])
  end
end
