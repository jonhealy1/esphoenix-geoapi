defmodule EsphoenixGeoapi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EsphoenixGeoapiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EsphoenixGeoapi.PubSub},
      # Start the Endpoint (http/https)
      EsphoenixGeoapiWeb.Endpoint,
      EsphoenixGeoapi.ElasticsearchCluster
      # Start a worker by calling: EsphoenixGeoapi.Worker.start_link(arg)
      # {EsphoenixGeoapi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EsphoenixGeoapi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EsphoenixGeoapiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
