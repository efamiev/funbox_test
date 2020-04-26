defmodule Funbox.Helpers.Url do
  def get_host_name(url) do
    case URI.parse(url) do
      %{:scheme => nil} -> url |> add_scheme |> get_host_name
      %{:host => host} -> host
    end
  end

  defp add_scheme(url) do
    "http://#{url}"
  end
end
