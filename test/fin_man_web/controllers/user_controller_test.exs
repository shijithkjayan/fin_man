defmodule FinManWeb.UserControllerTest do
  use FinManWeb.ConnCase
  use FinMan.Fixtures

  alias FinMan.Users.User

  @create_attrs %{
    name: "John Doe",
    email: "john@finman.com",
    password: "123123123"
  }

  @update_attrs %{
    name: "John Doe Jr",
    email: "john.jr@finman.com"
  }

  @invalid_attrs %{
    name: 1,
    email: "invalid"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      name = @create_attrs.name
      email = @create_attrs.email

      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert "Bad Request" = json_response(conn, 422)
    end
  end

  describe "show user" do
    setup [:create_user]

    test "renders user with valid ID", %{conn: conn, user: user} do
      %User{id: id, name: name, email: email} = user
      conn = get(conn, Routes.user_path(conn, :show, id))
    end

    test "renders errors when user not found", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :show, Ecto.UUID.generate()))

      assert "Not Found" = json_response(conn, 404)
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      name = @update_attrs.name
      email = @update_attrs.email
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      conn = get(conn, Routes.user_path(conn, :show, user))
      assert "Not Found" = json_response(conn, 404)
    end

    test "renders errors when user not found", %{conn: conn} do
      conn = delete(conn, Routes.user_path(conn, :delete, Ecto.UUID.generate()))

      assert "Not Found" = json_response(conn, 404)
    end
  end

  defp create_user(_) do
    user =
      user_fixture(name: "John Doe", email: "john@finman.com", password: "123123123")

    %{user: user}
  end
end
