defmodule LibreTradeWeb.PostLive do
  use LibreTradeWeb, :live_view

  alias LibreTrade.Posts
  alias LibreTradeWeb.CommentFormComponent

  def mount(%{"id" => id}, _session, socket) do
    socket =
      socket
      |> assign(:post, Posts.get_post!(id))
      |> stream(:comments, Posts.get_comments_by_post_id(id))

    {:ok, socket}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_info({:comment_created, comment}, socket) do
    {:noreply, stream_insert(socket, :comments, comment, at: 0)}
  end
end
