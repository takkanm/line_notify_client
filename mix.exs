defmodule LineNotifyClient.Mixfile do
  use Mix.Project

  def project do
    [app: :line_notify_client,
     version: "0.2.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [ main_module: CLI ],
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:poison, "~> 3.0"}
    ]
  end

  defp description do
    """
    Client for LINE Notify.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :line_notify_client,
     files: ["lib", "mix.exs", "README*"],
     maintainers: ["takkanm"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/takkanm/line_notify_client"}]
  end
end
