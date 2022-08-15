defmodule Sanchayika.Students.StudentTest do
  use ExUnit.Case
  import Ecto.Changeset

  alias Sanchayika.Students.Student

  @valid_params %{
    name: "Student 1",
    total_balance: 100.02
  }

  describe "changeset/2" do
    test "creates valid changeset with valid params" do
      changeset = Student.changeset(%Student{}, @valid_params)

      assert changeset.valid?
      assert @valid_params.name == get_change(changeset, :name)
      assert @valid_params.total_balance == get_change(changeset, :total_balance)
    end

    test "creates default value for total_balance" do
      params = Map.delete(@valid_params, :total_balance)
      changeset = Student.changeset(%Student{}, params)

      assert changeset.valid?
      assert @valid_params.name == get_change(changeset, :name)
      assert 0.0 == get_field(changeset, :total_balance)
    end

    test "validates name is required" do
      changeset = Student.changeset(%Student{}, %{})

      refute changeset.valid?
      assert %{name: ["can't be blank"]} = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates data types" do
      changeset = Student.changeset(%Student{}, %{name: 1, total_balance: "wrong"})

      refute changeset.valid?

      assert %{name: ["is invalid"], total_balance: ["is invalid"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end
  end
end
