defmodule Funbox do
  use Application
  require Logger

  def start(_type, _args) do
    port = String.to_integer(Application.fetch_env!(:funbox, :port))
    redis_port = Application.fetch_env!(:funbox, :redis_port)
    redis_host = Application.fetch_env!(:funbox, :redis_host)

    children = [
      {
        Plug.Cowboy,
        scheme: :http, plug: Funbox.Api, options: [port: port]
      },
      {Redix, {"redis://#{redis_host}:#{redis_port}", name: :redix, sync_connect: true}}
    ]

    opts = [strategy: :one_for_one, name: Funbox.Supervisor]

    Logger.info("Server running on port #{port}")

    Supervisor.start_link(children, opts)
  end
end
