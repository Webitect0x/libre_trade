defmodule LibreTradeWeb.ThreadFormComponent do
  use LibreTradeWeb, :live_component

  alias LibreTrade.Threads
  alias LibreTrade.Threads.Thread

  def mount(socket) do
    {:ok, assign_form(socket, Threads.change_thread(%Thread{}))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="save" phx-target={@myself}>
        <.input field={@form[:name]} />
        <.input field={@form[:description]} />
        <.button>Submit</.button>
      </.form>
    </div>
    """
  end

  def handle_event("save", %{"thread" => thread_params}, socket) do
    case Threads.create_thread(thread_params) do
      {:ok, _thread} ->
        send(self(), {:thread_created, thread_params})
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
