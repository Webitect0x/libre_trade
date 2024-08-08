defmodule LibreTradeWeb.CreatePostForm do
  use LibreTradeWeb, :live_component

  import LibreTradeWeb.Utils, only: [assign_form: 2]

  alias LibreTrade.Posts.Post
  alias LibreTrade.Posts

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign_form(Posts.change_post(%Post{}))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="create" phx-target={@myself}>
        <.input field={@form[:title]} />
        <.input field={@form[:content]} />
        <.button>Submit</.button>
      </.form>
    </div>
    """
  end

  def handle_event("create", %{"post" => params}, socket) do
    params =
      Map.merge(params, %{
        "thread_id" => socket.assigns.thread_id,
        "user_id" => socket.assigns.current_user.id
      })

    case Posts.create_post(params) do
      {:ok, post} ->
        socket =
          socket
          |> put_flash(:info, "Post created")
          |> push_navigate(to: "/forum/t/#{socket.assigns.thread_name}/post/#{post.id}")

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, socket |> assign_form(changeset)}
    end
  end
end
