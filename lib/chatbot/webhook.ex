defmodule Chatbot.Webhook do
  def send(message) do
    url = Application.get_env(:chatbot, :webhook_url)
    HTTPoison.post!(url, message)
  end
end
