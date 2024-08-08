defmodule LibreTradeWeb.ThreadLive do
  use LibreTradeWeb, :live_view
  import LibreTradeWeb.Components.Post

  alias LibreTradeWeb.CreatePostForm
  alias LibreTradeWeb.Components.ThreadBar
  alias LibreTrade.{Posts, Threads}

  def mount(%{"name" => name}, _session, socket) do
    thread = Threads.get_thread_by_name(name)

    if connected?(socket) do
      Posts.subscribe()
    end

    if is_nil(thread) do
      {:ok,
       socket
       |> put_flash(:error, "Thread not found")
       |> redirect(to: ~p"/explore")}
    else
      socket =
        socket
        |> assign(:thread, thread)

      {:ok, socket}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex gap-2">
      <div class="h-[90vh] w-4/5 overflow-y-scroll">
        <.post :for={post <- Enum.reverse(@thread.posts)} post={post} thread_name={@thread.name} />
      </div>
      <.live_component
        id="thread-bar"
        module={ThreadBar}
        thread={@thread}
        current_user={@current_user}
      />
      <.modal
        :if={@live_action == :new}
        id="create-post-modal"
        show
        on_cancel={JS.navigate(~p"/forum/t/#{@thread.name}")}
      >
        <.live_component
          module={CreatePostForm}
          id="create-post"
          thread_name={@thread.name}
          thread_id={@thread.id}
          current_user={@current_user}
        />
      </.modal>
    </div>
    """
  end

  def handle_info({:post_created, post}, socket) do
    {:noreply,
     assign(socket, :thread, %{
       socket.assigns.thread
       | posts: [post | socket.assigns.thread.posts]
     })}
  end
end
