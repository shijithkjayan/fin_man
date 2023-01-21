defmodule Sanchayika.StudentsTest do
  use Sanchayika.DataCase

  alias Sanchayika.Students.AcademicHistory
  alias Sanchayika.Students
  alias Sanchayika.Students.Student

  import ExUnit.CaptureLog
  import Sanchayika.StudentsFixtures
  import Sanchayika.ClassesFixtures
  import Sanchayika.YearsFixtures

  @invalid_attrs %{name: nil, total_balance: "john"}

  setup do
    year = year_fixture(start_year: 2022, end_year: 2023)
    class = class_fixture(class_name: "2A")

    student =
      student_with_academic_history_fixture(
        name: "John Doe",
        class_id: class.id,
        academic_year_id: year.id
      )

    {:ok, year: year, class: class, student: student}
  end

  test "list_student/0 returns all student", %{student: student} do
    assert Students.list_student() == [student]
  end

  describe "get_student!/1" do
    test "returns the student with given id", %{student: student} do
      assert Students.get_student!(student.id) == student
    end

    test "raises when not found" do
      assert_raise Ecto.NoResultsError, fn ->
        Students.get_student!(Ecto.UUID.generate())
      end
    end
  end

  describe "create_student/1" do
    test "with valid data creates a student and an academic history", %{
      class: %{id: class_id},
      year: %{id: year_id}
    } do
      valid_attrs = %{
        name: "John Doe",
        total_balance: 2000.01,
        class_id: class_id,
        academic_year_id: year_id
      }

      assert {:ok, %Student{id: student_id} = student} = Students.create_student(valid_attrs)

      assert student.name == valid_attrs.name
      assert student.total_balance == valid_attrs.total_balance

      assert %AcademicHistory{
               student_id: ^student_id,
               class_id: ^class_id,
               academic_year_id: ^year_id
             } =
               Repo.get_by(AcademicHistory,
                 student_id: student_id,
                 class_id: class_id,
                 academic_year_id: year_id
               )
    end

    test "with invalid data throws error log" do
      assert capture_log(fn -> assert :error = Students.create_student(@invalid_attrs) end) =~
               "create_student failed"
    end

    test "with invalid data returns :error" do
      assert :error = Students.create_student(@invalid_attrs)
    end

    test "with invalid class ID returns :error", %{year: %{id: year_id}} do
      valid_attrs = %{
        name: "John Doe",
        total_balance: 2000.01,
        class_id: Faker.UUID.v4(),
        academic_year_id: year_id
      }

      assert :error = Students.create_student(valid_attrs)
    end

    test "with invalid academic year ID returns :error", %{class: %{id: class_id}} do
      valid_attrs = %{
        name: "John Doe",
        total_balance: 2000.01,
        class_id: class_id,
        academic_year_id: Faker.UUID.v4()
      }

      assert :error = Students.create_student(valid_attrs)
    end
  end

  describe "update_student/2" do
    test "with valid data updates the student", %{student: student} do
      update_attrs = %{}

      assert {:ok, %Student{} = ^student} = Students.update_student(student, update_attrs)
    end

    test "with invalid data returns error changeset", %{student: student} do
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student == Students.get_student!(student.id)
    end
  end

  test "delete_student/1 deletes the student", %{student: student} do
    assert {:ok, %Student{}} = Students.delete_student(student)
    assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
  end

  test "change_student/1 returns a student changeset", %{student: student} do
    assert %Ecto.Changeset{} = Students.change_student(student)
  end
end
