# LineNotifyClient

Client for [LINE Notify](https://notify-bot.line.me/).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `line_notify_client` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:line_notify_client, "~> 0.1.0"}]
    end
    ```

  2. Ensure `line_notify_client` is started before your application:

    ```elixir
    def application do
      [applications: [:line_notify_client]]
    end
    ```

