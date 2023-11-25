defmodule FinManWeb.UserController do
  use FinManWeb, :controller

  alias FinMan.Users
  alias FinMan.Users.User

  action_fallback FinManWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/users/#{user}")
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      render(conn, "404.html")
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.html", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      render(conn, "404.html")
  end
end
