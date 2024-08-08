defmodule LibreTradeWeb.PostLive.Components do
  use Phoenix.Component

  def comment(assigns) do
    ~H"""
    <div class="glass-effect p-2">
      <.link patch={"/u/#{@comment.user.username}"}>
        <%= @comment.user.username %>
      </.link>
      <div>
        <%= @comment.content %>
      </div>
    </div>
    """
  end
end
