defmodule Funbox.Routes.VisitedLinksTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Funbox.Api

  # @opts Api.init([])

  # test "return 200 with a valid payload" do
  #   conn =
  #     :post
  #     |> conn("/visited_links", %{links: ["ya.ru", "funbox.ru"]})
  #     |> Api.call(@opts)

  #   {:ok, res} = Poison.decode(conn.resp_body)
  #   assert conn.status == 200
  #   assert res["status"] == "ok"
  # end
end
