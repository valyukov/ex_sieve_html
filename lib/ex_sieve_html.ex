defmodule ExSieve.HTML do
  @moduledoc """
  This module contains Phoenix helper function wrappers that help to build search form and sorting links for
  [ExSieve](https://hex.pm/packages/ex_sieve) less painful.
  """
  @spec search_form(Plug.Conn.t, String.t, (Phoenix.HTML.Form.t -> Phoenix.HTML.unsafe)) :: Phoenix.HTML.safe
  defdelegate search_form(conn, action, fun), to: ExSieve.HTML.SearchForm

  @spec search_form(Plug.Conn.t, String.t, Keyword.t, (Phoenix.HTML.Form.t -> Phoenix.HTML.unsafe)) :: Phoenix.HTML.safe
  defdelegate search_form(conn, action, options, fun), to: ExSieve.HTML.SearchForm

  @spec sort_link(Plug.Conn.t, String.t, String.t, Keyword.t) :: Phoenix.HTML.safe
  defdelegate sort_link(conn, field, text, opts), to: ExSieve.HTML.SortLink
end
