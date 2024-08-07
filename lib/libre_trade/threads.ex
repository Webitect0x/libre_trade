defmodule LibreTrade.Threads do
  @moduledoc """
  The Threads context.
  """

  import Ecto.Query, warn: false
  alias LibreTrade.Repo

  alias LibreTrade.Threads.Thread

  @doc """
  Returns the list of threads.

  ## Examples

      iex> list_threads()
      [%Thread{}, ...]

  """
  def list_threads do
    Repo.all(Thread)
  end

  @doc """
  Returns the list of threads with posts.

  ## Examples

      iex> list_threads_with_posts()
      [%Thread{posts: [%Post{}, ...]}, ...]

  """

  def list_threads_with_posts do
    Repo.all(Thread)
    |> Repo.preload(:posts)
  end

  @doc """
  Gets a single thread.

  Raises `Ecto.NoResultsError` if the Thread does not exist.

  ## Examples

      iex> get_thread!(123)
      %Thread{}

      iex> get_thread!(456)
      ** (Ecto.NoResultsError)

  """
  def get_thread!(id), do: Repo.get!(Thread, id)

  def get_thread_by_name(name) do
    Repo.get_by(Thread, name: name) |> Repo.preload(:posts)
  end

  @doc """
  Creates a thread.

  ## Examples

      iex> create_thread(%{field: value})
      {:ok, %Thread{}}

      iex> create_thread(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_thread(attrs \\ %{}) do
    %Thread{}
    |> Thread.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a thread.

  ## Examples

      iex> update_thread(thread, %{field: new_value})
      {:ok, %Thread{}}

      iex> update_thread(thread, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_thread(%Thread{} = thread, attrs) do
    thread
    |> Thread.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a thread.

  ## Examples

      iex> delete_thread(thread)
      {:ok, %Thread{}}

      iex> delete_thread(thread)
      {:error, %Ecto.Changeset{}}

  """
  def delete_thread(%Thread{} = thread) do
    Repo.delete(thread)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking thread changes.

  ## Examples

      iex> change_thread(thread)
      %Ecto.Changeset{data: %Thread{}}

  """
  def change_thread(%Thread{} = thread, attrs \\ %{}) do
    Thread.changeset(thread, attrs)
  end

  alias LibreTrade.Threads.Subscription

  @doc """
  Returns the list of subscribtions.

  ## Examples

      iex> list_subscribtions()
      [%Subscription{}, ...]

  """
  def list_subscriptions do
    Repo.all(Subscription)
  end

  @doc """
  Gets a single subscription.

  Raises `Ecto.NoResultsError` if the Subscription does not exist.

  ## Examples

      iex> get_subscription!(123)
      %Subscription{}

      iex> get_subscription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subscription!(id), do: Repo.get!(Subscription, id)

  def is_subscribed?(thread, user) do
    if user == nil do
      false
    else
      Repo.get_by(
        Subscription,
        thread_id: thread.id,
        subscriber_id: user.id
      ) != nil
    end
  end

  def toggle_subscription(thread, user, is_subscribed) do
    if is_subscribed do
      delete_subscription(thread, user)
    else
      create_subscription(
        thread,
        %{subscriber_id: user.id, thread_id: thread.id}
      )
    end
  end

  @doc """
  Creates a subscription.

  ## Examples

      iex> create_subscription(%{field: value})
      {:ok, %Subscription{}}

      iex> create_subscription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subscription(thread, attrs \\ %{}) do
    with {:ok, _} <-
           %Subscription{}
           |> Subscription.changeset(attrs)
           |> Repo.insert() do
      update_thread(thread, %{subscribers: thread.subscribers + 1})
    end
  end

  @doc """
  Updates a subscription.

  ## Examples

      iex> update_subscription(subscription, %{field: new_value})
      {:ok, %Subscription{}}

      iex> update_subscription(subscription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subscription(%Subscription{} = subscription, attrs) do
    subscription
    |> Subscription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subscription.

  ## Examples

      iex> delete_subscription(subscription)
      {:ok, %Subscription{}}

      iex> delete_subscription(subscription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subscription(thread, user) do
    dbg("DELETE SUBSCRIPTION")

    Repo.get_by(Subscription, thread_id: thread.id, subscriber_id: user.id)
    |> Repo.delete()

    update_thread(thread, %{subscribers: thread.subscribers - 1})
  end
end
