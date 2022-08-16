defmodule Sanchayika.Classes.Class do
  @moduledoc """
  Schema for classes.
  """
  use Sanchayika.Schema

  schema "class" do
    field :class_name, :string
    timestamps()
  end

  def changeset(%__MODULE__{} = class, params \\ %{}) do
    class
    |> cast(params, [:class_name])
    |> validate_required([:class_name])
    |> unique_constraint([:class_name], name: :class_name_unique_index)
    |> validate_format(:class_name, ~r/[1-4][A-Z]/,
      message: "class name should contain class followed by division in caps"
    )
  end
end
