defmodule FinMan.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinMan.Users` context.
  """
  alias FinMan.Users
  alias FinMan.Users.User
  alias FinMan.Repo

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    attrs = Enum.into(attrs, %{})

    {:ok, user} =
      %User{}
      |> Users.change_user(attrs)
      |> Repo.insert()

    user
  end
end
