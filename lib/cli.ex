defmodule CLI do
  def main(args) do
    option_strict = [image_thumbnail: :string, image_fullsize: :string]
    case OptionParser.parse(args, strict: option_strict) do
      {[], [token], _} ->
        LineNotifyClient.post_stdin(token)
      {[], [token|messages], _} ->
        LineNotifyClient.post(token, Enum.join(messages, " "))
      {options, [token|messages], _} ->
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
    [first|rest] = String.split(to_string(key), "_")
    rest |> Enum.map(fn(word) -> Macro.camelize(word) end) |> (&List.flatten(first, &1)).() |> List.to_string
  end

  def usage do
    IO.puts "line_notify_client [--image_thubnail url --image_fullsize url] token msg1 [msg2...]"
  end
end
