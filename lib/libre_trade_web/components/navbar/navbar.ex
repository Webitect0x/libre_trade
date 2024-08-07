defmodule LibreTradeWeb.Navbar do
  use LibreTradeWeb, :live_component

  import LibreTradeWeb.{ToggleMenu, Toggle}

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    ~H"""
    <nav class="glass-effect m-3 flex items-center justify-between px-5">
      <h1 class="text-2xl font-bold">LibreTrade</h1>

      <div class="flex gap-4">
        <.link navigate={~p"/"} class="text-[0.8125rem] leading-6 font-semibold">
          Market
        </.link>
        <.link navigate={~p"/forum"} class="text-[0.8125rem] leading-6 font-semibold">
          Forum
        </.link>
      </div>

      <ul class="relative z-10 flex items-center justify-end gap-4 px-4 sm:px-6 lg:px-8">
        <%= if @current_user do %>
          <li class="text-[0.8125rem] cursor-pointer leading-6" phx-click={toggle_menu()}>
            <%= @current_user.username %>
          </li>
          <.toggle_menu toggle={toggle_menu()} />
        <% else %>
          <li>
            <.link navigate={~p"/users/register"} class="text-[0.8125rem] leading-6 font-semibold">
              Register
            </.link>
          </li>
          <li>
            <.link navigate={~p"/users/log_in"} class="text-[0.8125rem] leading-6 font-semibold">
              Log in
            </.link>
          </li>
        <% end %>
      </ul>
    </nav>
    """
  end
end
