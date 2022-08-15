defmodule Sanchayika.Classes.ClassTest do
  use Sanchayika.DataCase

  alias Sanchayika.Classes.Class
  import Ecto.Changeset, only: [traverse_errors: 2]

  @valid_params %{
    class_name: "1A"
  }

  describe "changeset/2" do
    test "creates a valid changeset with valid params" do
      changeset = Class.changeset(%Class{}, @valid_params)

      assert changeset.valid?
    end

    test "creates invalid changeset with invalid params" do
      changeset = Class.changeset(%Class{}, %{class_name: 1.2})

      refute changeset.valid?
    end

    test "validates class_name is required" do
      changeset = Class.changeset(%Class{}, %{})

      refute changeset.valid?

      assert %{class_name: ["can't be blank"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates class_name contains a number followed by an alphabet only" do
      changeset1 = Class.changeset(%Class{}, %{class_name: "1A"})
      changeset2 = Class.changeset(%Class{}, %{class_name: "1"})

      assert changeset1.valid?
      refute changeset2.valid?

      assert %{class_name: ["class name should contain class followed by division in caps"]} =
               traverse_errors(changeset2, fn {msg, _opts} -> msg end)
    end

    test "validates class_name is unique" do
      _ = Repo.insert!(%Class{class_name: "2Q"})
      assert {:error, changeset} = %Class{} |> Class.changeset(%{class_name: "2Q"}) |> Repo.insert()

      assert %{class_name: ["has already been taken"]} = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end
  end
end
