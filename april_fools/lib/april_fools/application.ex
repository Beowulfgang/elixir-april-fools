defmodule AprilFools.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AprilFoolsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AprilFools.PubSub},
      # Start Finch
      {Finch, name: AprilFools.Finch},
      # Start the Endpoint (http/https)
      AprilFoolsWeb.Endpoint
      # Start a worker by calling: AprilFools.Worker.start_link(arg)
      # {AprilFools.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AprilFools.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AprilFoolsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
