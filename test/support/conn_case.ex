defmodule ExSieve.HTML.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
    end
  end

  setup do
    {:ok, conn: Phoenix.ConnTest.build_conn}
  end
end
