defmodule Chatbot.Router do
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "I'm alive")
  end

  post "/command" do
    response =
      conn.params["text"]
      |> String.split
      |> Chatbot.Command.execute()

    conn
    |> put_resp_header("Content-Type", "application/json")
    |> send_resp(200, Poison.encode!(%{text: response}))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
