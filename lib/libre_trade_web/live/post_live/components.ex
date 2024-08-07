defmodule LibreTradeWeb.Post.Components do
  use Phoenix.Component

  import LibreTradeWeb.CoreComponents, only: [icon: 1]

  def post(assigns) do
    ~H"""
    <div class="glass-effect m-4 flex gap-4 border-gray-200 p-4">
      <div class="flex flex-col items-center">
        <.icon name="hero-arrow-up-circle" class="h-4 w-4" />
        <span>0</span>
        <.icon name="hero-arrow-down-circle" class="h-4 w-4" />
      </div>

      <.link patch={"/forum/thread/#{@thread_name}/#{@post.id}"}>
        <h1 class="text-lg font-bold"><%= @post.title %></h1>
        <div>
          <%= @post.content %>
        </div>
      </.link>
    </div>
    """
  end
end
