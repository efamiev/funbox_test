defmodule Funbox.Routes.VisitedLinks do
  use Plug.Router
  alias Funbox.Routes.VisitedLinks

  plug(:match)
  plug(Plug.Validator, on_error: &Funbox.Api.on_error_fn/2)

  plug(:dispatch)

  post "/",
    private: %{
      validate: %{
        links: &VisitedLinks.validate_links/1
      }
    } do
    %{"links" => links} = conn.body_params

    host_names = Enum.map(links, &Funbox.Helpers.Url.get_host_name(&1))
    timestamp = DateTime.utc_now() |> DateTime.to_unix()

    {status, body} =
      case Funbox.Models.Domains.set(timestamp, host_names) do
        {:ok, _} -> {200, %{"status" => :ok}}
        {:error, error} -> {400, %{"status" => error}}
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(body))
  end

  def validate_links(links) do
    regex_url = ~r/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/

    unless is_list(links) &&
             Enum.all?(links, fn link -> is_binary(link) && String.match?(link, regex_url) end) do
      {:error, "unvalid url format"}
    end
  end
end
