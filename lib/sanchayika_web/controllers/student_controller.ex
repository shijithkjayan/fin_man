defmodule SanchayikaWeb.StudentController do
  use SanchayikaWeb, :controller

  alias Sanchayika.Students
  alias Sanchayika.Students.Student

  action_fallback SanchayikaWeb.FallbackController

  def index(conn, _params) do
    student = Students.list_student()
    render(conn, "index.json", student: student)
  end

  def create(conn, %{"student" => student_params}) do
    with {:ok, %Student{} = student} <- Students.create_student(student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.student_path(conn, :show, student))
      |> render("show.json", student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Students.get_student!(id)
    render(conn, "show.json", student: student)

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Students.get_student!(id)

    with {:ok, %Student{} = student} <- Students.update_student(student, student_params) do
      render(conn, "show.json", student: student)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Students.get_student!(id)

    with {:ok, %Student{}} <- Students.delete_student(student) do
      send_resp(conn, :no_content, "")
    end

    # To give a JSON response
  rescue
    Ecto.NoResultsError ->
      {:error, :not_found}
  end
end
