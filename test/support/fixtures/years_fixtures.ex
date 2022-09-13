defmodule Sanchayika.YearsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sanchayika.Years` context.
  """

  @doc """
  Generate a year.
  """
  def year_fixture(attrs \\ %{}) do
    {:ok, year} =
      attrs
      |> Enum.into(%{})
      |> Sanchayika.Years.create_year()

    year
  end
end
