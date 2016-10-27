defmodule CLI do
  def main([token, message]) do
    LineNotifyClient.post(token, message)
  end
end
