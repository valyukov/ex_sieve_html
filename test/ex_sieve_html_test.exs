defmodule ExSieve.HTMLTest do
  use ExSieve.HTML.ConnCase
  import Phoenix.HTML.Form, only: [text_input: 2]

  describe "ExSieve.HTML.search_form/3" do
    test "return form for search", %{conn: conn} do
      form = ~s(<form accept-charset="UTF-8" action="/" method="get"><input name="_utf8" type="hidden" value="✓"><input id="q_title_eq" name="q[title_eq]" type="text"></form>)

      result =
        ExSieve.HTML.search_form(conn, "/", &(text_input(&1, :title_eq)))
        |> Phoenix.HTML.safe_to_string

      assert form == result
    end
  end

  describe "ExSieve.HTML.search_form/4" do
    test "return post form for search", %{conn: conn} do
      form = ~s(<form accept-charset="UTF-8" action="/" method="post"><input name="_utf8" type="hidden" value="✓"><input id="q_title_eq" name="q[title_eq]" type="text"></form>)
      opts = [method: :post, csrf_token: false]

      result =
        ExSieve.HTML.search_form(conn, "/", opts, &(text_input(&1, :title_eq)))
        |> Phoenix.HTML.safe_to_string

      assert form == result
    end
  end

  describe "ExSieve.HTML.sort_link/4" do
    test "return a tag with sort params", %{conn: conn} do
      html = ~s(<a class=\"desc\" href=\"/?q[s]=name+desc\">test</a>)

      root_path = fn(_conn, :search, _params) -> "/?q[s]=name+desc" end

      result =
        conn
        |> Plug.Parsers.call([])
        |> ExSieve.HTML.sort_link(:name, "test", to: &(root_path.(conn, :search, &1)))
        |> Phoenix.HTML.safe_to_string

      assert html == result
    end
  end
end
