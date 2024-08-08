defmodule LibreTrade.Posts.Post.Query do
  import Ecto.Query

  alias LibreTrade.Posts.Comment

  def comments_by_post_id(post_id) do
    from c in Comment,
      where: c.post_id == ^post_id,
      order_by: [desc: c.inserted_at],
      preload: [:user]
  end
end
