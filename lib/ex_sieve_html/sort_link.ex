defmodule ExSieve.HTML.SortLink do
  @moduledoc false

  import Phoenix.HTML.Link, only: [link: 2]

  @directions ~w(desc asc)

  def sort_link(%Plug.Conn{params: params}, field, text, opts) do
    path_helper = Keyword.fetch!(opts, :to)

    {as, opts} = Keyword.pop(opts, :as, :q)
    {default_dir, opts} = Keyword.pop(opts, :default_direction, "desc")
    {class, opts} = Keyword.pop(opts, :class)

    {params, dir} = params |> append_params(as, default_dir, field)
    opts = opts |> Keyword.put(:class, append_class(class, dir))

    link(text, Keyword.put(opts, :to, path_helper.(params)))
  end

  defp append_params(params, as, default_dir, field) do
    as = to_string(as)
    path = [as, "s"]

    params = params |> Map.put_new(as, %{}) |> update_in(path, fn
      (nil) -> ""
      (value) -> value
    end)

    value = params |> get_in(path)

    dir = if same_field?(value, field) do
            value |> parse_direction |> opposite_direction(default_dir)
          else
            default_dir
          end

    params = put_in(params, path, "#{field} #{dir}")

    {params, dir}
  end

  defp same_field?(value, field) do
    value |> String.starts_with?(to_string(field))
  end

  defp parse_direction(value) do
    value |> String.split(~r/\s+/) |> Enum.find(&Enum.member?(@directions, &1))
  end

  defp opposite_direction("desc", _default), do: :asc
  defp opposite_direction("asc", _default), do: :desc
  defp opposite_direction(nil, default), do: default

  defp append_class(nil, direction), do: direction
  defp append_class(class_string, direction) do
    "#{class_string} #{direction}"
  end
end
