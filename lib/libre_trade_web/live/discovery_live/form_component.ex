defmodule LibreTradeWeb.DiscoveryLive.FormComponent do
  use LibreTradeWeb, :live_component

  alias LibreTrade.Communities.Community
  alias LibreTrade.Communities

  def mount(socket) do
    changeset = Communities.change_community(%Community{})

    {:ok, assign_form(socket, changeset)}
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

  def handle_event("save", %{"community" => community_params}, socket) do
    case Communities.create_community(community_params) do
      {:ok, _community} ->
        send(self(), {:community_created, community_params})
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
