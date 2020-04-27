defmodule Funbox.Routes.VisitedLinksTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Funbox.Api

  @opts Api.init([])

  describe "successful" do
    test "return 200 with a valid payload" do
      conn =
        :post
        |> conn("/visited_links", %{links: ["ya.ru", "funbox.ru"]})
        |> Api.call(@opts)

      {:ok, res} = Poison.decode(conn.resp_body)
      assert conn.status == 200
      assert res["status"] == "ok"
    end
  end

  describe "failure" do
    test "returns error when passing a domain as a number" do
      conn =
        :post
        |> conn("/visited_links", %{links: [1111, "funbox.ru"]})
        |> Api.call(@opts)

      {:ok, res} = Poison.decode(conn.resp_body)
      assert conn.status == 422
      assert res["status"]["links"] == "unvalid url format"
    end

    test "returns error when passing a domain without domain zone" do
      conn =
        :post
        |> conn("/visited_links", %{links: ["ya", "funbox.ru"]})
        |> Api.call(@opts)

      {:ok, res} = Poison.decode(conn.resp_body)
      assert conn.status == 422
      assert res["status"]["links"] == "unvalid url format"
    end
  end
end
