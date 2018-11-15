defmodule StreamingMetrics.PrometheusMetricCollector do
  @moduledoc false
  @behaviour StreamingMetrics.MetricCollector

  require Logger

  def init() do
    :ok
  end

  def count_metric(count, name, dimensions \\ [], _timestamp \\ []) do
    %{
      metric_name: name,
      value: count,
      dimensions: dimensions
    }
  end

  def record_metrics(metrics, namespace) do
    metrics
    |> Enum.map(fn metric ->
      :prometheus_gauge.declare(
        name: metric[:metric_name],
        labels: Keyword.keys(metric[:dimensions]),
        help: ""
      )
    end)

    metrics
    |> Enum.map(&set_gauge/1)
    |> Enum.reduce(
      {:ok, []},
      fn result, acc ->
        with {:ok, term} <- acc,
             :ok <- result,
             do: {:ok, term},
             else: (err -> err)
      end
    )
  end

  defp set_gauge(metric) do
    try do
      labels =
        metric[:dimensions]
        |> Keyword.values()

      :prometheus_gauge.set(metric[:metric_name], labels, metric[:value])
    rescue
      e in ErlangError -> {:error, e}
    end
  end
end
