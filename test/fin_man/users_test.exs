defmodule FinMan.UsersTest do
  use FinMan.DataCase, async: true
  use FinMan.Fixtures

  alias FinMan.Users
  alias FinMan.Users.User

  @invalid_attrs %{name: nil, email: 2}

  setup do
    user = user_fixture(name: "John Doe", email: "john@finman.com", password: "123123123")
    {:ok, %{user: user}}
  end

  describe "get_user!/1" do
    test "returns the user with given id", %{user: user} do
      response = Users.get_user!(user.id)

      assert response.id == user.id
      assert response.name == user.name
      assert response.email == user.email
    end

    test "raises when not found" do
      assert_raise Ecto.NoResultsError, fn ->
        Users.get_user!(Ecto.UUID.generate())
      end
    end
  end

  describe "create_user/1" do
    test "with valid data creates a user" do
      valid_attrs = %{name: "Jane Doe", email: "jane@finman.com", password: "123123123"}

      assert {:ok, user} = Users.create_user(valid_attrs)

      assert user.id
      assert user.name == valid_attrs.name
      assert user.email == valid_attrs.email
    end

    test "with invalid data returns error changeset" do
      assert {:error, changeset} = Users.create_user(@invalid_attrs)

      assert %{name: ["can't be blank"], email: ["is invalid"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end
  end

  describe "update_user/2" do
    test "with valid data updates the user", %{user: user} do
      update_attrs = %{name: "Jane Doe", email: "jane@finman.com"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.name == update_attrs.name
      assert user.email == update_attrs.email
    end

    test "with invalid data returns error changeset", %{user: user} do
      %{name: name, email: email} = user
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert %User{name: ^name, email: ^email} = Users.get_user!(user.id)
    end
  end

  test "delete_user/1 deletes the user", %{user: user} do
    assert {:ok, %User{}} = Users.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset", %{user: user} do
    assert %Ecto.Changeset{} = Users.change_user(user)
  end

  test "update_change_user/1 returns a user update changeset", %{user: user} do
    assert %Ecto.Changeset{} = Users.update_change_user(user)
  end
end
