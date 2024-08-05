defmodule LibreTradeWeb.ForumLive do
  use LibreTradeWeb, :live_view

  alias LibreTrade.Threads

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       :threads,
       Threads.list_threads()
     )}
  end
end
