defmodule LibreTrade.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias LibreTrade.Repo

  alias LibreTrade.Posts.Post

  alias LibreTrade.Posts.Post.Query

  def subscribe() do
    Phoenix.PubSub.subscribe(LibreTrade.PubSub, "threads")
  end

  def broadcast({:ok, data}, tag) do
    Phoenix.PubSub.broadcast(
      LibreTrade.PubSub,
      "threads",
      {tag, data}
    )

    {:ok, data}
  end

  def broadcast({:error, _changeset} = error, _tag), do: error

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post) |> Repo.preload([:user, :thread])
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id) |> Repo.preload([:user, :thread])

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Post.changeset(attrs)
    |> Repo.insert(preload: :user)
    |> case do
      {:ok, post} ->
        broadcast({:ok, Repo.preload(post, :user)}, :post_created)

      {:error, changeset} ->
        broadcast({:error, changeset}, :post_created)
    end
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  alias LibreTrade.Posts.Comment

  def subscribe_to_comments(post_id) do
    Phoenix.PubSub.subscribe(LibreTrade.PubSub, "post:#{post_id}")
  end

  def broadcast_comment_created({:ok, comment}, tag) do
    Phoenix.PubSub.broadcast(
      LibreTrade.PubSub,
      "post:#{comment.post_id}",
      {tag, comment}
    )

    {:ok, comment}
  end

  def broadcast_comment_created({:error, _changeset} = error, _tag), do: error

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment) |> Repo.preload(:user)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id) |> Repo.preload(:user)

  def get_comments_by_post_id(post_id) do
    Query.comments_by_post_id(post_id)
    |> Repo.all()
  end

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, comment} ->
        broadcast({:ok, Repo.preload(comment, :user)}, :comment_created)

      {:error, changeset} ->
        broadcast({:error, changeset}, :comment_created)
    end
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
