defmodule Canopy.MixProject do
  use Mix.Project

  @source_url "https://github.com/evilmarty/cando"

  def project do
    [
      app: :cando,
      description: "A simple and extensible permission system for Elixir applications.",
      source_url: @source_url,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :test,
      package: package(),
      deps: deps(),
      docs: [
        extras: ["README.md"]
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Marty Zalega"],
      licenses: ["MIT"],
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE),
      links: %{"GitHub" => @source_url}
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
