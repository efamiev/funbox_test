defmodule Funbox.Models.DomainsTest do
  use ExUnit.Case

  alias Funbox.Models.Domains

  @domains_list ["funbox.ru", "ya.ru"]
  @timestamp 1_545_221_231

  describe "writing data to the db" do
    setup do
      on_exit(fn -> clear_db() end)
      :ok
    end

    test "valid timestamp and domains list" do
      {status, _} = Domains.set(@timestamp, @domains_list)

      assert status == :ok
    end

    test "empty domains list" do
      {status, resp} = Domains.set(@timestamp, [])

      assert status == :ok
      assert resp == []
    end
  end

  describe "receiving data from the db" do
    setup do
      Domains.set(@timestamp, @domains_list)
      on_exit(fn -> clear_db() end)
      :ok
    end

    test "nonexistent domains data" do
      {status, resp} = Domains.get(@timestamp + 20, @timestamp + 20)

      assert status == :ok
      assert resp == []
    end

    test "existing domains data" do
      {status, resp} = Domains.get(@timestamp, @timestamp)

      assert status == :ok
      assert resp == @domains_list
    end
  end

  def clear_db() do
    timestamp = @timestamp

    {:ok, timestamp_list} =
      Redix.command(:redix, ["ZRANGEBYSCORE", "domains_visit_time", timestamp, timestamp])

    Redix.pipeline(:redix, [
      ["ZREMRANGEBYSCORE", "domains_visit_time", timestamp, timestamp],
      ["DEL" | timestamp_list]
    ])
  end
end
