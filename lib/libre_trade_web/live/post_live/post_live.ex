defmodule LibreTradeWeb.PostLive do
  use LibreTradeWeb, :live_view
  import LibreTradeWeb.PostLive.Components

  alias LibreTrade.Posts
  alias LibreTradeWeb.CreateCommentForm
  alias LibreTradeWeb.Components.ThreadBar

  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Posts.subscribe_to_comments(id)
    end

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
    dbg(comment)
    {:noreply, stream_insert(socket, :comments, comment, at: 0)}
  end
end
