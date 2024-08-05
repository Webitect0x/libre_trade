defmodule LibreTrade.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LibreTradeWeb.Telemetry,
      LibreTrade.Repo,
      {DNSCluster, query: Application.get_env(:libre_trade, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LibreTrade.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LibreTrade.Finch},
      # Start a worker by calling: LibreTrade.Worker.start_link(arg)
      # {LibreTrade.Worker, arg},
      # Start to serve requests, typically the last entry
      LibreTradeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LibreTrade.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LibreTradeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
