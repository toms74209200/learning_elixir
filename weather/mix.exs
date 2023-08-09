defmodule Weather.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather,
      escript: escript_config(),
      version: "0.1.0",
      name: "Weather",
      elixir: "~> 1.14",
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
      {:httpoison, "~> 2.1.0"}
    ]
  end

  defp escript_config do
    [
      main_module: Weather.CLI
    ]
  end
end
