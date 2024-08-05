defmodule LibreTradeWeb.PostLive do
  use LibreTradeWeb, :live_view

  alias LibreTrade.Threads

  def mount(%{"id" => id}, _session, socket) do
    post = Threads.get_post!(id)

    {:ok, socket |> assign(:post, post)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1><%= @post.title %></h1>
    </div>
    """
  end
end
