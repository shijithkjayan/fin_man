defmodule Sanchayika.Years do
  @moduledoc """
  Context for Academic years.
  """

  alias Sanchayika.Repo
  alias Sanchayika.Years.Year

  @typep success :: {:ok, Year.t()}
  @typep error :: {:error, Ecto.Changeset.t()}

  @doc """
  Returns the list of year.

  ## Examples

      iex> list_year()
      [%Year{}, ...]

  """
  @spec list_year() :: [Year.t()]
  def list_year, do: Repo.all(Year)

  @doc """
  Gets a single year.

  Raises if the Year does not exist.

  ## Examples

      iex> get_year!(123)
      %Year{}

  """
  @spec get_year!(Ecto.UUID.t()) :: Year.t()
  def get_year!(id), do: Repo.get!(Year, id)

  @doc """
  Creates a year.

  ## Examples

      iex> create_year(%{field: value})
      {:ok, %Year{}}

      iex> create_year(%{field: bad_value})
      {:error, ...}

  """
  @spec create_year(map()) :: success() | error()
  def create_year(attrs \\ %{}) do
    %Year{}
    |> change_year(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a year.

  ## Examples

      iex> update_year(year, %{field: new_value})
      {:ok, %Year{}}

      iex> update_year(year, %{field: bad_value})
      {:error, ...}

  """
  @spec update_year(Year.t(), map()) :: success() | error()
  def update_year(%Year{} = year, attrs) do
    year
    |> change_year(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Year.

  ## Examples

      iex> delete_year(year)
      {:ok, %Year{}}

      iex> delete_year(year)
      {:error, ...}

  """
  @spec delete_year(Year.t()) :: success() | error()
  def delete_year(%Year{} = year), do: Repo.delete(year)

  @doc """
  Returns a data structure for tracking year changes.

  ## Examples

      iex> change_year(year)
      %Todo{...}

  """
  @spec change_year(Year.t(), map()) :: Ecto.Changeset.t()
  def change_year(%Year{} = year, attrs \\ %{}) do
    Year.changeset(year, attrs)
  end
end
