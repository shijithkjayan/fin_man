defmodule Sanchayika.Students.AcademicHistoryTest do
  use Sanchayika.DataCase
  import Ecto.Changeset

  alias Sanchayika.Students.AcademicHistory
  import Sanchayika.ClassesFixtures
  import Sanchayika.StudentsFixtures
  import Sanchayika.YearsFixtures

  describe "changeset/2" do
    test "creates valid changeset with valid params" do
      %{id: student_id} = student_fixture(name: "John Doe", total_balance: 1021.23)
      %{id: class_id} = class_fixture(class_name: "1A")
      %{id: year_id} = year_fixture(start_year: 2023, end_year: 2024)

      changeset =
        AcademicHistory.changeset(%AcademicHistory{}, %{
          student_id: student_id,
          class_id: class_id,
          academic_year_id: year_id
        })

      assert changeset.valid?
      assert student_id == get_change(changeset, :student_id)
      assert class_id == get_change(changeset, :class_id)
      assert year_id == get_change(changeset, :academic_year_id)
    end

    test "validates required fields" do
      changeset = AcademicHistory.changeset(%AcademicHistory{}, %{})

      refute changeset.valid?

      assert %{
               student_id: ["can't be blank"],
               class_id: ["can't be blank"],
               academic_year_id: ["can't be blank"]
             } = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates data types" do
      changeset = AcademicHistory.changeset(%AcademicHistory{}, %{student_id: 1})

      refute changeset.valid?

      assert %{student_id: ["is invalid"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end
  end
end
