defmodule LibreTrade.ThreadsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LibreTrade.Threads` context.
  """

  @doc """
  Generate a thread.
  """
  def thread_fixture(attrs \\ %{}) do
    {:ok, thread} =
      attrs
      |> Enum.into(%{
        description: "some description",
        logo: "some logo",
        name: "some name"
      })
      |> LibreTrade.Threads.create_thread()

    thread
  end

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title"
      })
      |> LibreTrade.Threads.create_post()

    post
  end
end
