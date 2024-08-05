defmodule LibreTradeWeb.MarketLive do
  use LibreTradeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Market Live</h1>
    </div>
    """
  end
end
