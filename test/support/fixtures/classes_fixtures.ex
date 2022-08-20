defmodule Sanchayika.ClassesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sanchayika.Classes` context.
  """

  @doc """
  Generate a class.
  """
  def class_fixture(attrs \\ %{}) do
    {:ok, class} =
      attrs
      |> Enum.into(%{})
      |> Sanchayika.Classes.create_class()

    class
  end
end
