defmodule Sanchayika.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sanchayika.Students` context.
  """
  alias Sanchayika.Students
  alias Sanchayika.Students.Student
  alias Sanchayika.Repo

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    attrs = Enum.into(attrs, %{})

    {:ok, student} =
      %Student{}
      |> Students.change_student(attrs)
      |> Repo.insert()

    student
  end

  @doc """
  Generate a student and academic history.
  """
  def student_with_academic_history_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{})
      |> Sanchayika.Students.create_student()

    student
  end
end
