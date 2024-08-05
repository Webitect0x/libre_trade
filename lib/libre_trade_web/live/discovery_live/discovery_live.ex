defmodule LibreTradeWeb.DiscoveryLive do
  use LibreTradeWeb, :live_view

  alias LibreTradeWeb.DiscoveryLive
  alias LibreTrade.Threads

  def mount(_params, _session, socket) do
    {:ok, assign(socket, threads: Threads.list_threads())}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_info({:thread_created, thread_params}, socket) do
    IO.inspect(thread_params)
    {:noreply, socket}
  end
end
