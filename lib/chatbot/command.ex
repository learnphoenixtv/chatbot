defmodule Chatbot.Command do
  def execute(["chatbot", "help"]) do
    """
    chatbot gif <search terms>
    """
  end

  def execute(["chatbot", "gif" | terms]) do
    Task.async fn ->
      %{data: [gif]} = 
        terms
        |> Enum.join(" ")
        |> Giphy.search!(limit: 1)

      url = gif.images["original"]["url"]
      Chatbot.Webhook.send(url)
    end

    ""
  end

  def execute(_other) do
    """
    Could not execute command. See available commands with `chatbot help`.
    """
  end
end
