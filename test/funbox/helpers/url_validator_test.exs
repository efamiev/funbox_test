defmodule Funbox.Helpers.UrlTest do
  use ExUnit.Case, async: true
  alias Funbox.Helpers.Url

  describe "returns the correct host name" do
    test "url with protocol" do
      assert Url.get_host_name("https://ya.ru") == "ya.ru"
    end

    test "url without protocol" do
      assert Url.get_host_name("funbox.ru") == "funbox.ru"
    end
  end
end
