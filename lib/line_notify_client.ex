defmodule LineNotifyClient do
  @url "https://notify-api.line.me/api/notify"

  def post_message(token, message) do
    body = "message=#{message}"
    header = %{
      "Content-Type":   "application/x-www-form-urlencoded",
      "Authorization": "Bearer #{token}"
    }

    case HTTPoison.post(@url, body, header) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        :raise_400
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
