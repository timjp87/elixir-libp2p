defmodule Libp2p.MixProject do
  use Mix.Project

  def project do
    [
      app: :libp2p,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:protobuf, "~> 0.5.3"},
      {:poolboy, "~> 1.5"},
      {:basefiftyeight, "~> 0.1.0"},
      {:multiaddr, "~> 1.1"}
    ]
  end
end