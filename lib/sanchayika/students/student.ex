defmodule Sanchayika.Students.Student do
  @moduledoc """
  Schema for students.
  """
  use Sanchayika.Schema

  schema "student" do
    field :name, :string
    field :total_balance, :float, default: 0.0

    timestamps()
  end

  def changeset(%__MODULE__{} = student, params \\ %{}) do
    student
    |> cast(params, [:name, :total_balance])
    |> validate_required([:name, :total_balance])
  end
end
