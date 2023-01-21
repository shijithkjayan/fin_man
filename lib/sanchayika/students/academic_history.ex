defmodule Sanchayika.Students.AcademicHistory do
  @moduledoc """
  Schema for student's academic history.
  This schema connects student, class, and academic year.
  """
  use Sanchayika.Schema

  alias Sanchayika.Classes.Class
  alias Sanchayika.Students.Student
  alias Sanchayika.Years.Year

  @fields ~w(student_id class_id academic_year_id)a
  @primary_key false

  schema "academic_history" do
    belongs_to(:student, Student)
    belongs_to(:class, Class)
    belongs_to(:academic_year, Year)
  end

  def changeset(%__MODULE__{} = academic_history, params \\ %{}) do
    academic_history
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> foreign_key_constraint(:student_id)
    |> foreign_key_constraint(:class_id)
    |> foreign_key_constraint(:academic_year_id)
  end
end
