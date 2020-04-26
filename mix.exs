defmodule Funbox.MixProject do
  use Mix.Project

  def project do
    [
      app: :funbox,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Funbox, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 4.0.1"},
      {:plug_cowboy, "~> 2.1.2"},
      {:redix, "~> 0.10.5"},
      {:plug_validator, "~> 0.1.0"}
    ]
  end
end
