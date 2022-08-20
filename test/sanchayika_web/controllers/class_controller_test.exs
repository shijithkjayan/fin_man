defmodule SanchayikaWeb.ClassControllerTest do
  use SanchayikaWeb.ConnCase

  import Sanchayika.ClassesFixtures

  alias Sanchayika.Classes.Class

  @create_attrs %{class_name: "1A"}

  @update_attrs %{class_name: "1B"}

  @invalid_attrs %{class_name: "1b"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists empty list when there are no classes created", %{conn: conn} do
      conn = get(conn, Routes.class_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists classes", %{conn: conn} do
      %{class: class} = create_class(%{})
      conn = get(conn, Routes.class_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{"id" => class.id, "class_name" => class.class_name}
             ]
    end
  end

  describe "create class" do
    test "renders class when data is valid", %{conn: conn} do
      class_name = @create_attrs.class_name
      conn = post(conn, Routes.class_path(conn, :create), class: @create_attrs)

      assert %{"id" => _id, "class_name" => ^class_name} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.class_path(conn, :create), class: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show class" do
    setup [:create_class]

    test "renders class with valid ID", %{conn: conn, class: %Class{id: id}} do
      conn = get(conn, Routes.class_path(conn, :show, id))

      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end

    test "renders errors when class not found", %{conn: conn} do
      conn = get(conn, Routes.class_path(conn, :show, Ecto.UUID.generate()))

      assert "Not Found" = json_response(conn, 404)
    end
  end

  describe "update class" do
    setup [:create_class]

    test "renders class when data is valid", %{conn: conn, class: %Class{id: id} = class} do
      class_name = @update_attrs.class_name
      conn = put(conn, Routes.class_path(conn, :update, class), class: @update_attrs)

      assert %{"id" => ^id, "class_name" => ^class_name} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, class: class} do
      conn = put(conn, Routes.class_path(conn, :update, class), class: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when class not found", %{conn: conn} do
      conn =
        put(conn, Routes.class_path(conn, :update, Ecto.UUID.generate()), class: @update_attrs)

      assert "Not Found" = json_response(conn, 404)
    end
  end

  describe "delete class" do
    setup [:create_class]

    test "deletes chosen class", %{conn: conn, class: class} do
      conn = delete(conn, Routes.class_path(conn, :delete, class))
      assert response(conn, 204)

      conn = get(conn, Routes.class_path(conn, :show, class))
      assert "Not Found" = json_response(conn, 404)
    end

    test "renders errors when class not found", %{conn: conn} do
      conn = get(conn, Routes.class_path(conn, :delete, Ecto.UUID.generate()))

      assert "Not Found" = json_response(conn, 404)
    end
  end

  defp create_class(_) do
    class = class_fixture(class_name: "1A")
    %{class: class}
  end
end
