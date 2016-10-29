defmodule LineNotifyClient do
  @url "https://notify-api.line.me/api/notify"

  def post(token, message) do
    post_message(token, %{message: message})
  end

  def post(token, message, %{imageFullsize: image_fullsize, imageThumbnail: image_thumbnail}) do
    post_message(token, %{message: message, imageFullsize: image_fullsize, imageThumbnail: image_thumbnail})
  end

  defp post_message(token, params) do
    header = %{
      "Content-Type":  "application/x-www-form-urlencoded",
      "Authorization": "Bearer #{token}"
    }

    case HTTPoison.post(@url, URI.encode_query(params), header) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: 401, body: body}} ->
        {:raise_401, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        {:raise_400, Poison.decode!(body)}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, Poison.decode!(reason)}
    end
  end
end
