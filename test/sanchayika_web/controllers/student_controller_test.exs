defmodule SanchayikaWeb.StudentControllerTest do
  use SanchayikaWeb.ConnCase

  import Sanchayika.ClassesFixtures
  import Sanchayika.StudentsFixtures
  import Sanchayika.YearsFixtures

  alias Sanchayika.Students.Student

  @create_attrs %{
    name: "John Doe",
    total_balance: 200.0
  }

  @update_attrs %{
    name: "John Doe Jr",
    total_balance: 210.0
  }

  @invalid_attrs %{
    name: 1,
    total_balance: "invalid"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns empty list when there are no students created", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists students", %{conn: conn} do
      %{student: student} = create_student(%{})
      conn = get(conn, Routes.student_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{
                 "id" => student.id,
                 "name" => student.name,
                 "total_balance" => student.total_balance
               }
             ]
    end
  end

  describe "create student" do
    test "renders student when data is valid", %{conn: conn} do
      name = @create_attrs.name
      total_balance = @create_attrs.total_balance

      %{id: class_id} = class_fixture(class_name: "1A")
      %{id: year_id} = year_fixture(start_year: 2022, end_year: 2023)
      attrs = Map.merge(@create_attrs, %{class_id: class_id, academic_year_id: year_id})
      conn = post(conn, Routes.student_path(conn, :create), student: attrs)

      assert %{
               "id" => _id,
               "name" => ^name,
               "total_balance" => ^total_balance
             } = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @invalid_attrs)
      assert "Bad Request" = json_response(conn, 422)
    end
  end

  describe "show student" do
    setup [:create_student]

    test "renders student with valid ID", %{conn: conn, student: student} do
      %Student{id: id, name: name, total_balance: total_balance} = student
      conn = get(conn, Routes.student_path(conn, :show, id))

      assert %{
               "id" => _id,
               "name" => ^name,
               "total_balance" => ^total_balance
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when student not found", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :show, Ecto.UUID.generate()))

      assert "Not Found" = json_response(conn, 404)
    end
  end

  describe "update student" do
    setup [:create_student]

    test "renders student when data is valid", %{conn: conn, student: %Student{id: id} = student} do
      name = @update_attrs.name
      total_balance = @update_attrs.total_balance
      conn = put(conn, Routes.student_path(conn, :update, student), student: @update_attrs)

      assert %{
               "id" => ^id,
               "name" => ^name,
               "total_balance" => ^total_balance
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, student: student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete student" do
    setup [:create_student]

    test "deletes chosen student", %{conn: conn, student: student} do
      conn = delete(conn, Routes.student_path(conn, :delete, student))
      assert response(conn, 204)

      conn = get(conn, Routes.student_path(conn, :show, student))
      assert "Not Found" = json_response(conn, 404)
    end

    test "renders errors when student not found", %{conn: conn} do
      conn = delete(conn, Routes.student_path(conn, :delete, Ecto.UUID.generate()))

      assert "Not Found" = json_response(conn, 404)
    end
  end

  defp create_student(_) do
    year = year_fixture(start_year: 2022, end_year: 2023)
    class = class_fixture(class_name: "2A")

    student =
      student_with_academic_history_fixture(
        name: "John Doe",
        total_balance: 20.01,
        class_id: class.id,
        academic_year_id: year.id
      )

    %{student: student}
  end
end
