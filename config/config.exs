import Config

config :funbox,
  port: System.get_env("PORT"),
  redis_port: System.get_env("REDIS_PORT"),
  redis_host: System.get_env("REDIS_HOST")

# import_config "#{Mix.env()}.exs"
