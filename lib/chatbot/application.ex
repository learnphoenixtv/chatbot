defmodule Chatbot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port =
      case System.get_env("PORT") do
        nil -> 4000
        value -> String.to_integer(value)
      end

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Chatbot.Router, [], [port: port])
    ]

    opts = [strategy: :one_for_one, name: Chatbot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
