defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      escript: escript_config(),
      version: "0.1.0",
      name: "Issues",
      source_url: "https://github.com/toms74209200/learning_elixir",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
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
      {:httpoison, "~> 2.1.0"},
      {:poison, "~> 5.0"},
      {:ex_doc, "~> 0.30.4"},
      {:earmark, "~> 1.4"},
      {:excoveralls, "~> 0.17.1"}
    ]
  end

  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
