defmodule Funbox.Routes.VisitedDomains do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    %{"from" => from, "to" => to} = conn.params
    IO.inspect(conn.params, label: "Params")

    # get domains from db
    visited_domains = []
    # IO.inspect(timestamp_list, label: "timestamp_list")
    IO.inspect(visited_domains, label: "visited_domains")

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{"links" => visited_domains}))
  end
end
