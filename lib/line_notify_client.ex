defmodule LineNotifyClient do
  @url "https://notify-api.line.me/api/notify"

  def post(token, message) do
    post_message(token, %{message: message})
  end

  defp post_message(token, params) do
    header = %{
      "Content-Type":  "application/x-www-form-urlencoded",
      "Authorization": "Bearer #{token}"
    }

    case HTTPoison.post(@url, URI.encode_query(params), header) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        {:raise_400, body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
