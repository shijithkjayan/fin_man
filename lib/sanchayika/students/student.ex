defmodule Sanchayika.Students.Student do
  @moduledoc """
  Schema for students.
  """
  use Sanchayika.Schema

  alias Sanchayika.Students.AcademicHistory

  schema "student" do
    field :name, :string
    field :total_balance, :float, default: 0.0

    has_many(:academic_histories, AcademicHistory)

    timestamps()
  end

  def changeset(%__MODULE__{} = student, params \\ %{}) do
    student
    |> cast(params, [:name, :total_balance])
    |> validate_required([:name, :total_balance])
    |> validate_number(:total_balance,
      greater_than_or_equal_to: 0,
      message: "must be a positive value"
    )
  end
end
