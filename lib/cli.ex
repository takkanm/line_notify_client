defmodule CLI do
  def main(args) do
    option_switches = [
      image_thumbnail: :string,
      image_fullsize: :string,
      sticker_id: :integer,
      sticker_package_id: :integer,
    ]
    case OptionParser.parse(args, switches: option_switches) do
      {[], [token], _} ->
        LineNotifyClient.post_stdin(token)
      {[], [token|messages], []} ->
        LineNotifyClient.post(token, Enum.join(messages, " "))
      {[], [token|messages], options} ->
        options_map = convert_options_key(options) |> Map.new
        LineNotifyClient.post(token, Enum.join(messages, " "), options_map)
      _ ->
        usage
    end
  end

  defp convert_options_key(options) do
    Enum.map(options, fn({key, value}) -> {camelize_key(key), value} end)
  end

  defp camelize_key(key) do
    [first|rest] = to_string(key) |> String.trim_leading("--") |> String.split("_")
    rest |> Enum.map(fn(word) -> Macro.camelize(word) end) |> (&List.flatten([first], &1)).() |> List.to_string
  end

  def usage do
    IO.puts "line_notify_client [--sticker_id number --sticker_package_id number][--image_thubnail url --image_fullsize url] token msg1 [msg2...]"
  end
end
