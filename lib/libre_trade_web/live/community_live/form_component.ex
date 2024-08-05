defmodule LibreTradeWeb.CommunityLive.FormComponent do
  use LibreTradeWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Create Post</h1>
    </div>
    """
  end
end
