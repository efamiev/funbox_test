defmodule Funbox.Routes.VisitedLinks do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  post "/" do
    %{"links" => links} = conn.body_params

    host_names = Enum.map(links, &Funbox.Helpers.Url.get_host_name(&1))

    current_time = DateTime.utc_now() |> DateTime.to_unix()

    # set domains to db

    IO.inspect(Enum.uniq(host_names), label: "Host names")

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{"status" => "ok"}))
  end
end
