defmodule LibreTrade.CommunitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LibreTrade.Communities` context.
  """

  @doc """
  Generate a community.
  """
  def community_fixture(attrs \\ %{}) do
    {:ok, community} =
      attrs
      |> Enum.into(%{
        description: "some description",
        logo: "some logo",
        name: "some name"
      })
      |> LibreTrade.Communities.create_community()

    community
  end
end
