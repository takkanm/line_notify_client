defmodule CLI do
  def main(args) do
    option_strict = [image_thumbnail: :string, image_fullsize: :string]
    case OptionParser.parse(args, strict: option_strict) do
      {[], [token|messages], _} ->
        LineNotifyClient.post(token, Enum.join(messages, " "))
      {[image_thumbnail: image_thumbnail, image_fullsize: image_fullsize], [token|messages], _} ->
        LineNotifyClient.post(token, Enum.join(messages, " "), %{imageFullsize: image_fullsize, imageThumbnail: image_thumbnail})
      _ ->
        usage
    end
  end

  def usage do
    IO.puts "line_notify_client [--image_thubnail url --image_fullsize url] token msg1 [msg2...]"
  end
end
