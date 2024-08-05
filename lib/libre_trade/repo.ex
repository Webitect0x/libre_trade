defmodule LibreTrade.Repo do
  use Ecto.Repo,
    otp_app: :libre_trade,
    adapter: Ecto.Adapters.Postgres
end
