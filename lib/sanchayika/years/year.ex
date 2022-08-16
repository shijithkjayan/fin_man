defmodule Sanchayika.Years.Year do
  @moduledoc """
  Schema for academic years.
  """
  use Sanchayika.Schema

  schema "academic_year" do
    field :start_year, :integer
    field :end_year, :integer

    timestamps()
  end

  def changeset(%__MODULE__{} = year, params \\ %{}) do
    year
    |> cast(params, [:start_year, :end_year])
    |> validate_required([:start_year, :end_year])
    |> validate_academic_year()
  end

  defp validate_academic_year(%{valid?: true} = changeset) do
    start_year = get_change(changeset, :start_year)
    end_year = get_change(changeset, :end_year)

    if start_year == end_year - 1 do
      changeset
    else
      add_error(changeset, :start_year, "end year should be the next year of start year")
    end
  end

  defp validate_academic_year(changeset), do: changeset
end
