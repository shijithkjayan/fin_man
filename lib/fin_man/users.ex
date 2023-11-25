defmodule FinMan.Users do
  @moduledoc """
  Context for Users.
  """

  alias FinMan.Users.User
  alias FinMan.Repo

  @doc """
  Gets a single user.

  Raises if the user does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, ...}

  """
  def create_user(attrs) do
    %User{} |> change_user(attrs) |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, ...}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> change_user(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, ...}

  """
  def delete_user(%User{} = user), do: Repo.delete(user)

  @doc """
  Returns a data structure for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Todo{...}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    user.changeset(user, attrs)
  end
end
