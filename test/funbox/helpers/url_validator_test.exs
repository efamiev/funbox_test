defmodule Funbox.Helpers.UrlTest do
  use ExUnit.Case, async: true
  alias Funbox.Helpers.Url

  describe "get host name" do
    test "url with scheme" do
      assert Url.get_host_name("https://ya.ru") == "ya.ru"
    end

    test "url without scheme" do
      assert Url.get_host_name("funbox.ru") == "funbox.ru"
    end
  end
end
