defmodule SanchayikaWeb.YearControllerTest do
  use SanchayikaWeb.ConnCase

  import Sanchayika.YearsFixtures

  alias Sanchayika.Years.Year

  @create_attrs %{
    start_year: 2022,
    end_year: 2023
  }
  @update_attrs %{
    start_year: 2023,
    end_year: 2024
  }
  @invalid_attrs %{
    start_year: 2024,
    end_year: 2023
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns empty list when no years are created", %{conn: conn} do
      conn = get(conn, Routes.year_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists all years", %{conn: conn} do
      %{year: year} = create_year(%{})
      conn = get(conn, Routes.year_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{"id" => year.id, "start_year" => year.start_year, "end_year" => year.end_year}
             ]
    end
  end

  describe "create year" do
    test "renders year when data is valid", %{conn: conn} do
      start_year = @create_attrs.start_year
      end_year = @create_attrs.end_year

      conn = post(conn, Routes.year_path(conn, :create), year: @create_attrs)

      assert %{"id" => <<_::288>>, "start_year" => ^start_year, "end_year" => ^end_year} =
               json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.year_path(conn, :create), year: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show year" do
    setup [:create_year]

    test "renders year with valid ID", %{conn: conn, year: %Year{id: id} = yr} do
      start_year = yr.start_year
      end_year = yr.end_year

      conn = get(conn, Routes.year_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "start_year" => ^start_year,
               "end_year" => ^end_year
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when year not found", %{conn: conn} do
      conn = get(conn, Routes.year_path(conn, :show, Ecto.UUID.generate()))

      assert "Not Found" = json_response(conn, 404)
    end
  end

  describe "update year" do
    setup [:create_year]

    test "renders year when data is valid", %{conn: conn, year: %Year{id: id} = year} do
      start_year = @update_attrs.start_year
      end_year = @update_attrs.end_year
      conn = put(conn, Routes.year_path(conn, :update, year), year: @update_attrs)

      assert %{
               "id" => ^id,
               "start_year" => ^start_year,
               "end_year" => ^end_year
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, year: year} do
      conn = put(conn, Routes.year_path(conn, :update, year), year: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when year not found", %{conn: conn} do
      conn = put(conn, Routes.year_path(conn, :update, Ecto.UUID.generate()), year: @update_attrs)

      assert "Not Found" = json_response(conn, 404)
    end
  end

  describe "delete year" do
    setup [:create_year]

    test "deletes chosen year", %{conn: conn, year: year} do
      conn = delete(conn, Routes.year_path(conn, :delete, year))
      assert response(conn, 204)

      conn = get(conn, Routes.year_path(conn, :show, year))
      assert "Not Found" = json_response(conn, 404)
    end

    test "renders errors when year not found", %{conn: conn} do
      conn = delete(conn, Routes.year_path(conn, :delete, Ecto.UUID.generate()))

      assert "Not Found" = json_response(conn, 404)
    end
  end

  defp create_year(_) do
    year = year_fixture(start_year: 2022, end_year: 2023)
    %{year: year}
  end
end
