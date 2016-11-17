defmodule LineNotifyClient do
  @url "https://notify-api.line.me/api/notify"

  def post_stdin(token) do
    post(token, Enum.join(read_stdin, ""))
  end

  defp read_stdin do
    read_stdin([])
  end

  defp read_stdin(lines) do
    case IO.read(:stdio, :line) do
      :eof             -> lines
      {:error, reason} -> IO.puts "Error: #{reason}"
      data             -> read_stdin(lines ++ [data])
    end
  end

  def post(token, message) do
    post_message(token, %{message: message})
  end

  def post(token, message, options) do
    post_message(token, Map.merge(%{message: message}, options))
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
