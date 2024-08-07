defmodule LibreTradeWeb.CommentFormComponent do
  use LibreTradeWeb, :live_component

  alias LibreTrade.Posts
  alias LibreTrade.Posts.Post

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
      <.form for={@form} phx-submit="create_comment" class="m-4" phx-target={@myself}>
        <label for="content">Speak your mind</label>
        <.input field={@form[:content]} type="textarea" />
        <.button class="mt-2">Save</.button>
      </.form>
    </div>
    """
  end

  def handle_event("create_comment", %{"post" => post}, socket) do
    params =
      Map.merge(post, %{
        "user_id" => socket.assigns.current_user.id,
        "post_id" => socket.assigns.post_id
      })

    case Posts.create_comment(params) do
      {:ok, comment} ->
        send(self(), {:comment_created, comment})

        {:noreply,
         push_patch(socket,
           to: "/forum/thread/#{socket.assigns.thread_name}/#{socket.assigns.post_id}"
         )}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  def assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
