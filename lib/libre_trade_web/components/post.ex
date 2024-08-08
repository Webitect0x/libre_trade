defmodule LibreTradeWeb.Components.Post do
  use Phoenix.Component

  import LibreTradeWeb.CoreComponents, only: [icon: 1]

  attr :thread_name, :string, required: true
  attr :post, :map, required: true
  slot :inner_block

  def post(assigns) do
    ~H"""
    <div class="glass-effect m-4 flex items-center gap-4 border-gray-200 p-4">
      <div class="flex flex-col items-center">
        <.icon name="hero-arrow-up-circle" class="h-4 w-4" />
        <span>0</span>
        <.icon name="hero-arrow-down-circle" class="h-4 w-4" />
      </div>

      <.link patch={"/forum/t/#{@thread_name}/post/#{@post.id}"} class="w-full">
        <h1 class="text-xs"><%= @post.user.username %> * <%= @post.inserted_at %></h1>
        <h1 class="text-lg font-bold"><%= @post.title %></h1>
        <div>
          <%= @post.content %>
        </div>
        <%= render_slot(@inner_block) %>
      </.link>
    </div>
    """
  end
end
