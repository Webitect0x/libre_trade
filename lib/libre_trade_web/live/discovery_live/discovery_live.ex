defmodule LibreTradeWeb.DiscoveryLive do
  use LibreTradeWeb, :live_view

  alias LibreTradeWeb.DiscoveryLive
  alias LibreTrade.Communities

  def mount(_params, _session, socket) do
    {:ok, assign(socket, communities: Communities.list_communities())}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_info({:community_created, community_params}, socket) do
    IO.inspect(community_params)
    {:noreply, socket}
  end
end
