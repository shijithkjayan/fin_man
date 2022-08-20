defmodule Sanchayika.ClassesTest do
  use Sanchayika.DataCase

  alias Sanchayika.Classes
  alias Sanchayika.Classes.Class

  import Sanchayika.ClassesFixtures

  @invalid_attrs %{class_name: "1a"}

  test "list_class/0 returns all class" do
    class = class_fixture(class_name: "1A")
    assert Classes.list_class() == [class]
  end

  describe "get_class/1" do
    test "returns the class with given id" do
      class = class_fixture(class_name: "1A")
      assert Classes.get_class!(class.id) == class
    end

    test "raises when not found" do
      assert_raise Ecto.NoResultsError, fn ->
        Classes.get_class!(Ecto.UUID.generate())
      end
    end
  end

  describe "create_class/1" do
    test "with valid data creates a class" do
      valid_attrs = %{class_name: "1A"}

      assert {:ok, %Class{class_name: "1A"} = _class} = Classes.create_class(valid_attrs)
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Classes.create_class(@invalid_attrs)
    end
  end

  describe "update_class/2" do
    test "with valid data updates the class" do
      class = class_fixture(class_name: "1A")
      update_attrs = %{class_name: "1B"}

      assert {:ok, %Class{} = updated_class} = Classes.update_class(class, update_attrs)
      assert updated_class == Classes.get_class!(class.id)
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture(class_name: "1A")
      assert {:error, %Ecto.Changeset{}} = Classes.update_class(class, @invalid_attrs)
      assert class == Classes.get_class!(class.id)
    end
  end

  test "delete_class/1 deletes the class" do
    class = class_fixture(class_name: "1A")
    assert {:ok, %Class{}} = Classes.delete_class(class)
    assert_raise Ecto.NoResultsError, fn -> Classes.get_class!(class.id) end
  end

  test "change_class/1 returns a class changeset" do
    class = class_fixture(class_name: "1A")
    assert %Ecto.Changeset{} = Classes.change_class(class)
  end
end
