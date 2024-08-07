defmodule LibreTrade.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LibreTrade.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title",
        upvotes: 42
      })
      |> LibreTrade.Posts.create_post()

    post
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> LibreTrade.Posts.create_comment()

    comment
  end
end
