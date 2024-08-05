defmodule LibreTradeWeb.ToggleMenu do
  use Phoenix.Component

  def toggle_menu(assigns) do
    ~H"""
    <ul
      id="toggle-menu"
      hidden
      class="mt-[6rem] glass-effect absolute px-4"
      phx-click-away={assigns.toggle}
    >
      <li>
        <.link navigate="/users/settings" class="text-[0.8125rem] leading-6 font-semibold">
          Settings
        </.link>
      </li>
      <li>
        <.link href="/users/log_out" method="delete" class="text-[0.8125rem] leading-6 font-semibold">
          Log out
        </.link>
      </li>
    </ul>
    """
  end
end
