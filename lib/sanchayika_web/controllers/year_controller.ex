defmodule SanchayikaWeb.YearController do
  use SanchayikaWeb, :controller

  alias Sanchayika.Years
  alias Sanchayika.Years.Year

  action_fallback SanchayikaWeb.FallbackController

  def index(conn, _params) do
    year = Years.list_year()
    render(conn, "index.json", year: year)
  end

  def create(conn, %{"year" => year_params}) do
    with {:ok, %Year{} = year} <- Years.create_year(year_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.year_path(conn, :show, year))
      |> render("show.json", year: year)
    end
  end

  def show(conn, %{"id" => id}) do
    year = Years.get_year!(id)
    render(conn, "show.json", year: year)

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end

  def update(conn, %{"id" => id, "year" => year_params}) do
    year = Years.get_year!(id)

    with {:ok, %Year{} = year} <- Years.update_year(year, year_params) do
      render(conn, "show.json", year: year)
    end

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end

  def delete(conn, %{"id" => id}) do
    year = Years.get_year!(id)

    with {:ok, %Year{}} <- Years.delete_year(year) do
      send_resp(conn, :no_content, "")
    end

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end
end
