defmodule Whatlangex.MixProject do
  use Mix.Project

  def project do
    [
      app: :whatlangex,
      version: "0.2.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Whatlang NIF bindings",
      homepage_url: "https://github.com/pierrelegall/whatlangex",
      package: package()
    ]
  end

  def package() do
    [
      maintainers: ["Pierre Le Gall"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/pierrelegall/whatlangex"
      },
      files: ~w(lib priv native .formatter.exs mix.exs README* LICENSE* CHANGELOG*)
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
      {:ex_doc, ">= 0.29.0", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:rustler, "~> 0.26.0"}
    ]
  end
end
