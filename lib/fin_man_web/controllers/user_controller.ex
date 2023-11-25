defmodule FinManWeb.UserController do
  use FinManWeb, :controller

  alias FinMan.Users
  alias FinMan.Users.User

  action_fallback FinManWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, %User{} = user} ->
        conn
        |> put_resp_header("location", ~p"/users/#{user}")
        |> resp(:created, "User created")

      _error ->
        :error
    end
  end

  def show(conn, %{"id" => id}) do
    Users.get_user!(id)
    resp(conn, :ok, "")

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      resp(conn, :not_found, "Not Found")
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = _user} <- Users.update_user(user, user_params) do
      resp(conn, :ok, "")
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      resp(conn, :no_content, "")
    end

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      resp(conn, :not_found, "Not Found")
  end
end
