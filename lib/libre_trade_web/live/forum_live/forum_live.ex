defmodule LibreTradeWeb.ForumLive do
  use LibreTradeWeb, :live_view

  alias LibreTrade.Communities

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       :communities,
       Communities.list_communities()
     )}
  end
end
