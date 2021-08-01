defmodule ExmealWeb.Plugs.UUIDCheckerTest do
  use ExmealWeb.ConnCase, async: true

  alias Ecto.UUID
  alias ExmealWeb.Plugs.UUIDChecker
  alias Plug.Conn

  describe "call/2" do
    test "when id is valid, return conn", %{conn: _conn} do
      id = UUID.generate()
      opts = "test"

      response = UUIDChecker.call(%Conn{params: %{"id" => id}}, opts)

      assert %Plug.Conn{
               params: %{"id" => ^id}
             } = response
    end
  end
end
