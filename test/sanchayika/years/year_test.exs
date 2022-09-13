defmodule Sanchayika.Years.YearTest do
  use ExUnit.Case

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Sanchayika.Years.Year

  @valid_params %{
    start_year: 2022,
    end_year: 2023
  }

  describe "changeset/2" do
    test "creates valid changeset with valid params" do
      changeset = Year.changeset(%Year{}, @valid_params)

      assert changeset.valid?
    end

    test "creates invalid changeset with invalid params" do
      changeset = Year.changeset(%Year{}, %{start_year: "asdf", end_year: "ghjk"})

      refute changeset.valid?
    end

    test "validates start_year and end_year are required" do
      changeset = Year.changeset(%Year{}, %{})

      refute changeset.valid?

      assert %{start_year: ["can't be blank"], end_year: ["can't be blank"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates start_year and end_year must be b/w 2021 and 10000" do
      changeset = Year.changeset(%Year{}, %{start_year: 22, end_year: 10_001})

      refute changeset.valid?

      assert %{
               end_year: ["year must be between 2021 and 10000"],
               start_year: ["year must be between 2021 and 10000"]
             } = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end

    test "validates end_year is the next year after start_year" do
      changeset = Year.changeset(%Year{}, %{start_year: 2022, end_year: 2024})

      refute changeset.valid?

      assert %{start_year: ["end year should be the next year of start year"]} =
               traverse_errors(changeset, fn {msg, _opts} -> msg end)
    end
  end
end
