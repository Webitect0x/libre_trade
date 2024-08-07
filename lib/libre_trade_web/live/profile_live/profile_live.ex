defmodule LibreTradeWeb.ProfileLive do
  use LibreTradeWeb, :live_view

  alias LibreTrade.Accounts

  def mount(%{"username" => username}, _session, socket) do
    user = Accounts.get_user_by_username(username)

    if is_nil(user) do
      {:ok, assign(socket, user: user)}
    else
      {:ok, assign(socket, user: user)}
    end
  end
end
