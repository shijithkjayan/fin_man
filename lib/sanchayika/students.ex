defmodule Sanchayika.Students do
  @moduledoc """
  Context for Students.
  """

  import Ecto, only: [build_assoc: 2]
  require Logger

  alias Ecto.Multi
  alias Sanchayika.Students.AcademicHistory
  alias Sanchayika.Students.Student
  alias Sanchayika.Repo

  @doc """
  Returns the list of student.

  ## Examples

      iex> list_student()
      [%Student{}, ...]

  """
  def list_student do
    Repo.all(Student)
  end

  @doc """
  Gets a single student.

  Raises if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

  """
  def get_student!(id), do: Repo.get!(Student, id)

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, ...}

  """
  def create_student(attrs) do
    Multi.new()
    |> Multi.insert(:student, change_student(%Student{}, attrs))
    |> Multi.insert(:academic_history, fn %{student: student} ->
      student |> build_assoc(:academic_histories) |> AcademicHistory.changeset(attrs)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{student: student, academic_history: _academic_history}} ->
        {:ok, student}

      {:error, _, error, _} ->
        Logger.error("create_student failed", error: error)
        :error
    end
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, ...}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> change_student(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, ...}

  """
  def delete_student(%Student{} = student), do: Repo.delete(student)

  @doc """
  Returns a data structure for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Todo{...}

  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end
end
