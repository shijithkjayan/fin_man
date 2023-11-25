defmodule FinManWeb.PageControllerTest do
  use FinManWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert response(conn, 200)
  end
end
