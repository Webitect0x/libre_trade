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
  Generate a subscription.
  """
  def subscription_fixture(attrs \\ %{}) do
    {:ok, subscription} =
      attrs
      |> Enum.into(%{})
      |> LibreTrade.Threads.create_subscription()

    subscription
  end
end
