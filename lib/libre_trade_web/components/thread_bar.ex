defmodule LibreTradeWeb.Components.ThreadBar do
  use LibreTradeWeb, :live_component

  alias LibreTrade.Threads

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign(
        is_subscribed:
          Threads.is_subscribed?(
            assigns.thread,
            assigns.current_user
          )
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="h-[90vh] glass-effect w-1/5 text-center">
      <div class="flex flex-col items-center gap-2">
        <img src={@thread.logo} class="w-[5rem] h-[5rem] mt-[2rem] rounded-full" />
        <h1 class="text-2xl font-bold">/t/<%= String.capitalize(@thread.name) %></h1>
        <div>
          <span class="text-xs">Subscribers: <%= @thread.subscribers %></span>
        </div>
        <%= @thread.description %>

        <ul>
          <li class="flex flex-col gap-2">
            <.link :if={@current_user} patch={"/forum/t/#{@thread.name}/new"}>
              Create Post
            </.link>
            <button
              :if={@current_user && !@is_subscribed}
              phx-click="toggle_subscription"
              phx-target={@myself}
            >
              Subscribe
            </button>
            <button
              :if={@current_user && @is_subscribed}
              phx-click="toggle_subscription"
              phx-target={@myself}
            >
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

  def handle_event("toggle_subscription", _params, socket) do
    %{
      thread: thread,
      current_user: current_user,
      is_subscribed: is_subscribed
    } = socket.assigns

    Threads.toggle_subscription(thread, current_user, is_subscribed)

    {:noreply, socket}
  end

  # defp update_subscription_status(socket, is_subscribed, thread, delta) do
  #   assign(socket,
  #     is_subscribed: is_subscribed,
  #     thread: %{
  #       thread
  #       | subscribers: thread.subscribers + delta
  #     }
  #   )
  # end
end
