defmodule Funbox.Routes.VisitedDomainsTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Funbox.Api

  # @opts Api.init([])

  # test "returns visited domains list with a valid payload" do
  #   conn =
  #     :get
  #     |> conn("/visited_domains", %{from: 1_545_221_231, to: 1_545_217_638})
  #     |> Api.call(@opts)

  #   {:ok, res} = Poison.decode(conn.resp_body)
  #   assert res["links"] == []
  # end
end
