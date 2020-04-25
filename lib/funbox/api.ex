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
end
