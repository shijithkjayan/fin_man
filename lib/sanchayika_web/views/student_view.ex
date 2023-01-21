defmodule SanchayikaWeb.StudentView do
  use SanchayikaWeb, :view
  alias SanchayikaWeb.StudentView

  def render("index.json", %{student: student}) do
    %{data: render_many(student, StudentView, "student.json")}
  end

  def render("show.json", %{student: student}) do
    %{data: render_one(student, StudentView, "student.json")}
  end

  def render("student.json", %{student: student}) do
    %{
      id: student.id,
      name: student.name,
      total_balance: student.total_balance
    }
  end
end
