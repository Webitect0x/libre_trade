defmodule LibreTradeWeb.ThreadLive do
  use LibreTradeWeb, :live_view

  import LibreTradeWeb.Post.Components
  import LibreTradeWeb.Components.ThreadBar

  alias LibreTradeWeb.PostFormComponent
  alias LibreTrade.Posts
  alias LibreTrade.Threads

  def mount(%{"name" => name}, _session, socket) do
    thread = Threads.get_thread_by_name(name)

    if connected?(socket) do
      Posts.subscribe()
    end

    if is_nil(thread) do
      {:ok,
       socket
       |> put_flash(:error, "Thread not found")
       |> redirect(to: ~p"/forum/discovery")}
    else
      socket =
        socket
        |> assign(:thread, thread)
        |> assign(
          :is_subscribed,
          Threads.is_subscribed?(
            thread,
            socket.assigns.current_user
          )
        )

      {:ok, socket}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_info({:post_created, post}, socket) do
    {:noreply,
     assign(socket, :thread, %{
       socket.assigns.thread
       | posts: [post | socket.assigns.thread.posts]
     })}
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
