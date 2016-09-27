# ExSieve.HTML

[![Build Status](https://travis-ci.org/valyukov/ex_sieve_html.svg?branch=master)](https://travis-ci.org/valyukov/ex_sieve_html)
[![Hex Version](http://img.shields.io/hexpm/v/ex_sieve_html.svg?style=flat)](https://hex.pm/packages/ex_sieve_html)
[![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/ex_sieve_html)

ExSieve.HTML is helper functions `ExSieve.HTML.search_form/3`, `ExSieve.HTML.search_form/4` and `ExSieve.HTML.sort_link/4`
for Phoenix which helps to build [ExSieve](https://github.com/valyukov/ex_sieve) query object.

## Installation

1. Add `ex_sieve` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_sieve_html, "~> 0.1.0"},
  ]
end
```
2. `mix deps.get`

## Ussage

First of all import ExSieve.HTML. The best place would probably be inside view/0 in your web/web.ex, in order to make the functions available in all of your views.

```elixir
defmodule MyApp.Web do
...skip
def view do
  quote do
    use Phoenix.View, root: "web/templates"

    import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

    use Phoenix.HTML

    import MyApp.Router.Helpers
    import MyApp.ErrorHelpers
    import MyApp.Gettext
    import ExSieve.HTML
  end
end
...skip
```

then, setup your controller, add [ExSieve](https://github.com/valyukov/ex_sieve) for filtering your scheme.

```elixir
def index(conn, %{"q"=> q}) do
  posts = MyApp.Post |> MyApp.Repo.filter(q)

  render conn, :index, posts: posts
end
```

### search_form/3

Build simple html form. It use default "q" `%{"q" => %{...}}` filter namespase (as params pass to your controller).
```eex
<%= search_form @conn, post_path(@conn, :index), fn(f) -> %>
  <%= text_input f, :title_eq %>
  <%= text_input f, :body_cont %>
  <%= submit "Search" %>
<% end %>
```

### search_form/4

This function does the same things, but allow to customize form, e.g. change params key from "q" to "search". Also it allow to
set form send method, in this example it changes to `POST`. You can use any other options, available for
`Phoenix.HTML.Form.form_for/4`
```eex
<%= search_form @conn, post_path(@conn, :index), [as: :search, method: :post] fn(f) -> %>
  <%= text_input f, :title_eq %>
  <%= text_input f, :body_cont %>
  <%= submit "Search" %>
<% end %>
```

### sort_link/4
This helps to make up sort link (usually it used in table headers). Pay attention to this: `to: &(post_path(@conn, :index,
&1))` attribute, it wraps `post_path/3` helper  into anonimous functions that allows to call it inside `sort_link/4` with
modifyed parameters (sort direction).

```eex
<table>
  <thead>
    <tr>
      <th>
        <%= sort_link(@conn, :title, humanize(:title), to: &(post_path(@conn, :index, &1)), default_direction: :asc) %>
      </th>
      <th>
        <%= sort_link(@conn, :body, humanize(:body), to: &(post_path(@conn, :index, &1))) %>
      </th>
      <th>
        <%= sort_link(@conn, :inserted_at, humanize(:inserted_at), to: &(post_path(@conn, :index, &1))) %>
      </th>
      <th>
        <%= sort_link(@conn, :uptaded_at, humanize(:uptaded_at), to: &(post_path(@conn, :index, &1))) %>
      </th>
    </tr>
  </thead>
  <tbody>
    ...
  </tbody>
```

## Contributing

```sh
mix test
mix credo
mix dialyzer
```

If all fine, your ready to send your PR.
