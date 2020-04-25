defmodule Funbox.Helpers.Url do
  @spec get_host_name(String.t()) :: String.t()
  def get_host_name(url) do
    case URI.parse(url) do
      %{:host => nil} -> url |> add_protocol |> get_host_name
      %{:host => host} -> host
    end
  end

  defp add_protocol(url) do
    "http://#{url}"
  end
end
