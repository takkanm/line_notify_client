# LineNotifyClient

Client for [LINE Notify](https://notify-bot.line.me/).

## Installation

### for libliry

If [available in Hex](https://hex.pm/packages/line_notify_client), the package can be installed as:

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

### for Command Line

```shell
$ mix escript.install github github takkanm/line_notify_client
```

## Command Line Usage

```shell
$ line_notify_client [--image_thubnail url --image_fullsize url] token msg1 [msg2...]
```
