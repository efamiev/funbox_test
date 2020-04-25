defmodule Funbox.Models.Domains do
  def set(_, []), do: {:ok, []}

  def set(timestamp, domains_list) do
    Redix.pipeline(:redix, [
      ["ZADD", "domains_visit_time", timestamp, "visited_domains:#{timestamp}"],
      ["SADD", "visited_domains:#{timestamp}" | domains_list]
    ])
  end

  def get(from, to) do
    case Redix.command(:redix, ["ZRANGEBYSCORE", "domains_visit_time", from, to]) do
      {:ok, []} -> {:ok, []}
      {:ok, timestamp_list} -> Redix.command(:redix, ["SUNION" | timestamp_list])
      {:error, reason} -> {:error, reason}
    end
  end
end
