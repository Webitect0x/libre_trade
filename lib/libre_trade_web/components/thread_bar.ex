defmodule LibreTradeWeb.Components.ThreadBar do
  use Phoenix.Component

  def thread_bar(assigns) do
    ~H"""
    <div class="h-[90vh] w-1/5 border text-center">
      <div class="flex flex-col gap-2">
        <h1 class="mt-[2rem] text-2xl font-bold"><%= String.capitalize(@thread.name) %></h1>
        <div>
          <span class="text-xs">Subscribers: <%= @thread.subscribers %></span>
        </div>
        <%= @thread.description %>

        <ul>
          <li class="flex flex-col gap-2">
            <.link :if={@current_user} patch={"/forum/thread/#{@thread.name}/new"}>
              Create Post
            </.link>
            <button :if={@current_user && !@is_subscribed} phx-click="toggle_subscription">
              Subscribe
            </button>
            <button :if={@current_user && @is_subscribed} phx-click="toggle_subscription">
              Unsubscribe
            </button>
            <.link>Chat</.link>
          </li>
        </ul>

        <h4>Moderators</h4>
        <ul>
          <li>
            <.link navigate="/forum/discovery">
              Admin
            </.link>
          </li>
        </ul>
      </div>
    </div>
    """
  end
end
