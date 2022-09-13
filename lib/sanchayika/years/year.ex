defmodule Sanchayika.Years.Year do
  @moduledoc """
  Schema for academic years.
  """
  use Sanchayika.Schema

  @type t :: %__MODULE__{}

  @number_validation_message "year must be between 2021 and 10000"

  schema "academic_year" do
    field :start_year, :integer
    field :end_year, :integer

    timestamps()
  end

  def changeset(%__MODULE__{} = year, params \\ %{}) do
    year
    |> cast(params, [:start_year, :end_year])
    |> validate_required([:start_year, :end_year])
    |> validate_number(:start_year,
      greater_than: 2021,
      less_than: 10000,
      message: @number_validation_message
    )
    |> validate_number(:end_year,
      greater_than: 2021,
      less_than: 10000,
      message: @number_validation_message
    )
    |> validate_academic_year()
  end

  defp validate_academic_year(%{valid?: true} = changeset) do
    start_year = get_field(changeset, :start_year)
    end_year = get_field(changeset, :end_year)

    if start_year == end_year - 1 do
      changeset
    else
      add_error(changeset, :start_year, "end year should be the next year of start year")
    end
  end

  defp validate_academic_year(changeset), do: changeset
end
