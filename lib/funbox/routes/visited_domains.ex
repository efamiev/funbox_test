defmodule Funbox.Routes.VisitedDomains do
  use Plug.Router
  alias Funbox.Routes.VisitedDomains

  plug(:match)
  plug(Plug.Validator, on_error: &Funbox.Api.on_error_fn/2)

  plug(:dispatch)

  get "/",
    private: %{
      validate: %{
        from: &VisitedDomains.validate_timestamp/1,
        to: &VisitedDomains.validate_timestamp/1
      }
    } do
    %{"from" => from, "to" => to} = conn.params

    {status, body} =
      case Funbox.Models.Domains.get(from, to) do
        {:ok, resp} -> {200, %{"status" => :ok, "links" => resp}}
        {:error, error} -> {400, %{"status" => error}}
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(body))
  end

  def validate_timestamp(timestamp) do
    case Integer.parse(timestamp) do
      :error -> {:error, "could not parse #{timestamp} as integer"}
      other -> other
    end
  end
end
