defmodule Chatapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChatappWeb.Telemetry,
      # Start the Ecto repository
      Chatapp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Chatapp.PubSub},
      # Start Finch
      {Finch, name: Chatapp.Finch},
      # Start the Endpoint (http/https)
      ChatappWeb.Endpoint
      # Start a worker by calling: Chatapp.Worker.start_link(arg)
      # {Chatapp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chatapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
