defmodule FinMan.Users.UserTest do
  use ExUnit.Case, async: true
  import Ecto.Changeset

  alias FinMan.Users.User

  @valid_params %{
    name: "User 1",
    email: "user@finman.com",
    password: "123123123"
  }

  @valid_update_params Map.drop(@valid_params, [:password])

  describe "changeset/2" do
    test "creates valid changeset with valid params" do
      changeset = User.changeset(%User{}, @valid_params)

      assert changeset.valid?
      assert @valid_params.name == get_change(changeset, :name)
      assert @valid_params.email == get_change(changeset, :email)
      assert @valid_params.password == get_change(changeset, :password)
      assert get_change(changeset, :encrypted_password)

      assert true ==
               Bcrypt.verify_pass(
                 @valid_params.password,
                 get_change(changeset, :encrypted_password)
               )
    end

    test "validates name is required" do
      changeset = User.changeset(%User{}, %{})

      refute changeset.valid?
      assert %{name: ["can't be blank"]} = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates email is required" do
      changeset = User.changeset(%User{}, %{})

      refute changeset.valid?
      assert %{email: ["can't be blank"]} = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates data types" do
      changeset = User.changeset(%User{}, %{name: 1, email: 2})

      refute changeset.valid?

      assert %{name: ["is invalid"], email: ["is invalid"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates email format" do
      changeset = User.changeset(%User{}, %{name: "user", email: "invalid"})

      refute changeset.valid?

      assert %{email: ["has invalid format"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end
  end

  describe "update_changeset/2" do
    test "creates valid changeset with valid params" do
      changeset = User.update_changeset(%User{}, @valid_update_params)

      assert changeset.valid?
      assert @valid_update_params.name == get_change(changeset, :name)
      assert @valid_update_params.email == get_change(changeset, :email)
    end

    test "validates name is required" do
      changeset = User.update_changeset(%User{}, %{})

      refute changeset.valid?
      assert %{name: ["can't be blank"]} = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates email is required" do
      changeset = User.update_changeset(%User{}, %{})

      refute changeset.valid?
      assert %{email: ["can't be blank"]} = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates email format" do
      changeset = User.update_changeset(%User{}, %{name: "user", email: "invalid"})

      refute changeset.valid?

      assert %{email: ["has invalid format"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end
  end
end
