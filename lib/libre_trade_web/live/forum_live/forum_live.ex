defmodule LibreTradeWeb.ForumLive do
  use LibreTradeWeb, :live_view

  alias LibreTrade.{Posts, Threads}

  import LibreTradeWeb.Post.Components
  # import LibreTradeWeb.Components.ThreadBar

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       threads: Threads.list_threads(),
       posts: Posts.list_posts()
     )}
  end
end
