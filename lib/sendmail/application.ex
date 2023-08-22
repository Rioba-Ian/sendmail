defmodule Sendmail.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SendmailWeb.Telemetry,
      # Start the Ecto repository
      Sendmail.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Sendmail.PubSub},
      # Start Finch
      {Finch, name: Sendmail.Finch},
      # Start the Endpoint (http/https)
      SendmailWeb.Endpoint
      # Start a worker by calling: Sendmail.Worker.start_link(arg)
      # {Sendmail.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sendmail.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SendmailWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
