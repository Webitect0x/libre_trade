defmodule LibreTradeWeb.ThreadLive.PostFormComponent do
  use LibreTradeWeb, :live_component

  alias LibreTrade.Threads.Post
  alias LibreTrade.Threads

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign_form(Threads.change_post(%Post{}))

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

    case Threads.create_post(params) do
      {:ok, _post} ->
        socket =
          socket
          # |> push_navigate(to: "/forum/thread/#{socket.assigns.thread_name}/#{post.id}")
          |> put_flash(:info, "Post created")

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, socket |> assign_form(changeset)}
    end
  end

  def assign_form(socket, thread) do
    assign(socket, :form, to_form(thread))
  end
end
