defmodule Funbox.ApiTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Funbox.Api

  @opts Api.init([])

  test "returns 404 when no route matches" do
    conn =
      :get
      |> conn("/404")
      |> Api.call(@opts)

    assert conn.status == 404
  end
end
