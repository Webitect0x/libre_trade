defmodule LibreTradeWeb.ForumLive do
  use LibreTradeWeb, :live_view

  alias LibreTrade.{Posts, Threads}

  import LibreTradeWeb.Components.Post
  import LibreTradeWeb.Components.Filter
  import LibreTradeWeb.ForumLive.Components

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       threads: Threads.list_threads(),
       posts: Posts.list_posts()
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="flex gap-2">
      <div class="h-[90vh] glass-effect w-full overflow-y-scroll p-2 text-xs">
        <.filter>
          <%= Phoenix.HTML.Form.options_for_select(
            ["Most Recent", "Trending"],
            "Most Recent"
          ) %>
        </.filter>

        <.post :for={post <- @posts} post={post} thread_name={post.thread.name}>
          <div class="mt-2 text-xs">
            Posted In <%= post.thread.name %>
          </div>
        </.post>
      </div>

      <.side_bar threads={@threads} />
    </div>
    """
  end
end
