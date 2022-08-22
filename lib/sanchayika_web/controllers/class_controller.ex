defmodule SanchayikaWeb.ClassController do
  use SanchayikaWeb, :controller

  alias Sanchayika.Classes
  alias Sanchayika.Classes.Class

  action_fallback SanchayikaWeb.FallbackController

  def index(conn, _params) do
    class = Classes.list_class()
    render(conn, "index.json", class: class)
  end

  def create(conn, %{"class" => class_params}) do
    with {:ok, %Class{} = class} <- Classes.create_class(class_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.class_path(conn, :show, class))
      |> render("show.json", class: class)
    end
  end

  def show(conn, %{"id" => id}) do
    class = Classes.get_class!(id)
    render(conn, "show.json", class: class)

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Classes.get_class!(id)

    with {:ok, %Class{} = class} <- Classes.update_class(class, class_params) do
      render(conn, "show.json", class: class)
    end

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end

  def delete(conn, %{"id" => id}) do
    class = Classes.get_class!(id)

    with {:ok, %Class{}} <- Classes.delete_class(class) do
      send_resp(conn, :no_content, "")
    end
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end
end
