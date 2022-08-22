defmodule Sanchayika.Classes do
  @moduledoc """
  Context for Classes.
  """

  alias Sanchayika.Classes.Class
  alias Sanchayika.Repo

  @doc """
  Returns the list of class.

  ## Examples

      iex> list_class()
      [%Class{}, ...]

  """
  def list_class do
    Repo.all(Class)
  end

  @doc """
  Gets a single class.

  Raises if the Class does not exist.

  ## Examples

      iex> get_class!(123)
      %Class{}

  """
  def get_class!(id), do: Repo.get!(Class, id)

  @doc """
  Creates a class.

  ## Examples

      iex> create_class(%{field: value})
      {:ok, %Class{}}

      iex> create_class(%{field: bad_value})
      {:error, ...}

  """
  def create_class(attrs \\ %{}) do
    %Class{}
    |> change_class(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a class.

  ## Examples

      iex> update_class(class, %{field: new_value})
      {:ok, %Class{}}

      iex> update_class(class, %{field: bad_value})
      {:error, ...}

  """
  def update_class(%Class{} = class, attrs) do
    class
    |> change_class(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Class.

  ## Examples

      iex> delete_class(class)
      {:ok, %Class{}}

      iex> delete_class(class)
      {:error, ...}

  """
  def delete_class(%Class{} = class) do
    Repo.delete(class)
  end

  @doc """
  Returns a data structure for tracking class changes.

  ## Examples

      iex> change_class(class)
      %Todo{...}

  """
  def change_class(%Class{} = class, attrs \\ %{}) do
    Class.changeset(class, attrs)
  end
end
