defmodule Chatbot do
  def command(["chatbot", "help"]) do
    """
    chatbot gif <search terms>
    """
  end

  def command(["chatbot", "gif" | terms]) do
  end
end
