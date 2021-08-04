defmodule Markex.MixProject do
  use Mix.Project

  def project do
    [
      app: :markex,
      version: "1.0.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/wmean-spec/markex",

      package: [
        name: "Markex",
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
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
    ]
  end
end
