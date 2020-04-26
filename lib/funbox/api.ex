defmodule Funbox.Api do
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  forward("/visited_domains", to: Funbox.Routes.VisitedDomains)

  forward("/visited_links", to: Funbox.Routes.VisitedLinks)

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  def on_error_fn(conn, errors) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(422, Poison.encode!(%{status: errors}))
    |> halt
  end
end
