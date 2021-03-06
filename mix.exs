defmodule StreamingMetrics.MixProject do
  use Mix.Project

  def project do
    [
      app: :streaming_metrics,
      version: "2.2.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      source_url: "https://github.com/smartcitiesdata/streaming_metrics"
    ]
  end

  def application do
    [
      mod: {StreamingMetrics, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_aws, "~> 2.1"},
      {:ex_aws_cloudwatch, "~> 2.0"},
      {:ex_doc, "~> 0.20", only: :dev},
      {:httpoison, "~> 1.5"},
      {:mock, "~> 0.3", only: :test, runtime: false},
      {:prometheus_ex, "~> 3.0"},
      {:husky, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    "A metrics recording library"
  end

  defp package do
    [
      maintainers: ["smartcitiesdata"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/smartcitiesdata/streaming_metrics"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: "https://www.github.com/smartcitiesdata/streaming_metrics",
      extras: [
        "README.md"
      ]
    ]
  end
end
