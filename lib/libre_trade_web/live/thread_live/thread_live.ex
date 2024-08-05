defmodule LibreTradeWeb.ThreadLive do
  use LibreTradeWeb, :live_view

  import LibreTradeWeb.ThreadLive.Components

  alias LibreTradeWeb.ThreadLive.PostFormComponent
  alias LibreTrade.Threads

  def mount(%{"name" => name}, _session, socket) do
    thread = Threads.get_thread_by_name(name)

    if connected?(socket) do
      Threads.subscribe()
    end

    if is_nil(thread) do
      {:ok,
       socket
       |> put_flash(:error, "Thread not found")
       |> redirect(to: ~p"/forum/discovery")}
    else
      socket =
        socket
        |> assign(:posts, Enum.reverse(thread.posts))
        |> assign(:thread_name, name)
        |> assign(:thread_description, thread.description)
        |> assign(:thread_id, thread.id)

      {:ok, socket}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_info({:post_created, post}, socket) do
    dbg(socket.assigns.posts)

    {:noreply, assign(socket, :posts, [post | socket.assigns.posts])}
  end
end
