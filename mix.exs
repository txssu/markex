defmodule Markex.MixProject do
  use Mix.Project

  def project do
    [
      app: :markex,
      version: "1.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/wmean-spec/markex",

      description: "A small package for creating 2D markup.",

      package: [
        name: "markex",
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/wmean-spec/markex"},
      ],

      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
    ]
  end
end
