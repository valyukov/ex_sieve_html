defmodule ExSieve.HTML.SortLinkTest do
  use ExSieve.HTML.ConnCase

  describe "ExSieve.HTML.sort_link/4" do
    test "return a tag with sort params", %{conn: conn} do
      html = ~s(<a class=\"desc\" href=\"/?q[s]=id+desc\">test</a>)

      result =
        conn
        |> Plug.Parsers.call([])
        |> ExSieve.HTML.sort_link(:id, "test", to: &(assert_params_path(conn, :search, &1)))
        |> Phoenix.HTML.safe_to_string

      assert html == result
    end

    test "return a tag with sort params with: default_direction:", %{conn: conn} do
      html = ~s(<a class=\"asc\" href=\"/?q[s]=id+asc\">test</a>)

      result =
        conn
        |> Plug.Parsers.call([])
        |> ExSieve.HTML.sort_link(:id, "test", default_direction: :asc, to: &(assert_params_path(conn, :search, &1)))
        |> Phoenix.HTML.safe_to_string

      assert html == result
    end

    test "return a tag with sort params with as:", %{conn: conn} do
      html = ~s(<a class=\"desc\" href=\"/?search[s]=id+desc\">test</a>)

      result =
        conn
        |> Plug.Parsers.call([])
        |> ExSieve.HTML.sort_link(:id, "test", as: :search, to: &(assert_params_path(conn, :search, &1)))
        |> Phoenix.HTML.safe_to_string

      assert html == result
    end

    test "return default dirrection for new s value", %{conn: conn} do
      html = ~s(<a class=\"desc\" href=\"/?q[s]=id+desc\">test</a>)

      result =
        conn
        |> Map.put(:params, %{"q" => %{"s" => "name desc"}})
        |> ExSieve.HTML.sort_link(:id, "test", to: &(assert_params_path(conn, :search, &1)))
        |> Phoenix.HTML.safe_to_string

      assert html == result
    end

    test "append direction to a tag class", %{conn: conn} do
      html = ~s(<a class=\"class desc\" href=\"/?q[s]=id+desc\">test</a>)

      result =
        conn
        |> Plug.Parsers.call([])
        |> ExSieve.HTML.sort_link(:id, "test", to: &(assert_params_path(conn, :search, &1)), class: "class")
        |> Phoenix.HTML.safe_to_string

      assert html == result
    end

  end

  defp assert_params_path(_conn, _action, %{"q" => %{"s" => s}}) do
    "/?q[s]=#{String.replace(s, " ", "+")}"
  end

  defp assert_params_path(_conn, _action, %{"search" => %{"s" => s}}) do
    "/?search[s]=#{String.replace(s, " ", "+")}"
  end
end
