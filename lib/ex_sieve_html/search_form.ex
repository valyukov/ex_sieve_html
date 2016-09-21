defmodule ExSieve.HTML.SearchForm do
  @moduledoc false
  import Phoenix.HTML.Form, only: [form_for: 4]

  def search_form(%Plug.Conn{} = conn, action, opts \\ [], fun) do
    options = opts |> Keyword.put_new(:as, :q) |> Keyword.put_new(:method, :get)
    form_for(conn, action, options, fun)
  end
end
