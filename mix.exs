defmodule ExSieve.HTML.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_sieve_html,
      version: "0.3.0",
      elixir: "~> 1.3",
      elixirc_paths: elixirc_paths(Mix.env),
      package: package,
      description: "Phoenix helpers search_form/4 and sort_link/4 for ExSieve filtration library.",
      deps: deps,
      dialyzer: [plt_add_deps: :transitive],
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:credo, "~> 0.4", only: :dev},
      {:dialyxir, "~> 0.3.5", only: :dev},
      {:ex_doc, "~> 0.13.0", only: :dev},
      {:phoenix, "~> 1.2.1", only: :test},
      {:phoenix_html, "~> 2.7"}
    ]
  end

  defp package do
    [
      maintainers: ["Vlad Alyukov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/valyukov/ex_sieve_html"},
      files: ["README.md", "LICENSE", "mix.exs", "lib/*", "CHANGELOG.md"]
    ]
  end
end
