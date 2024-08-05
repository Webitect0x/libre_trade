defmodule LibreTradeWeb.CommunityLive do
  use LibreTradeWeb, :live_view

  alias LibreTradeWeb.CommunityLive.FormComponent

  alias LibreTrade.Communities

  def mount(%{"name" => name}, _session, socket) do
    community = Communities.get_community_by_name(name)

    if is_nil(community) do
      {:ok,
       socket
       |> put_flash(:error, "Community not found")
       |> redirect(to: ~p"/forum/discovery")}
    else
      {:ok, assign(socket, community: community)}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex gap-2">
      <div class="h-[90vh] w-4/5 border"></div>

      <div class="h-[90vh] w-1/5 border text-center">
        <div class="flex flex-col gap-2">
          <h1 class="mt-[2rem]"><%= @community.name %></h1>
          <div>
            <%= @community.description %>
          </div>
          <ul>
            <li class="flex flex-col gap-2">
              <.link patch={~p"/forum/#{@community.name}/new"}>Create Post</.link>
              <.link>Subscribe</.link>
              <.link>Chat</.link>
            </li>
          </ul>

          <h4>Moderators</h4>
          <ul>
            <li>
              <.link navigate={~p"/forum/discovery"}>
                Admin
              </.link>
            </li>
          </ul>
        </div>
      </div>
      <.modal
        :if={@live_action == :new}
        id="create-post-modal"
        show
        on_cancel={JS.navigate(~p"/forum/#{@community.name}")}
      >
        <.live_component module={FormComponent} id="create-post" />
      </.modal>
    </div>
    """
  end
end
