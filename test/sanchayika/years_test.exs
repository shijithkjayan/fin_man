defmodule Sanchayika.YearsTest do
  use Sanchayika.DataCase

  alias Sanchayika.Years
  alias Sanchayika.Years.Year

  import Sanchayika.YearsFixtures

  @invalid_attrs %{start_year: 2022, end_year: 2024}

  test "list_year/0 returns all year" do
    year = year_fixture(start_year: 2022, end_year: 2023)
    assert Years.list_year() == [year]
  end

  describe "get_year!/1" do
    test "returns the year with given id" do
      year = year_fixture(start_year: 2022, end_year: 2023)
      assert Years.get_year!(year.id) == year
    end

    test "raises when year not found" do
      assert_raise Ecto.NoResultsError, fn ->
        Years.get_year!(Ecto.UUID.generate())
      end
    end
  end

  describe "create_year/1" do
    test "with valid data creates a year" do
      start_yr = 2022
      end_yr = 2023

      assert {:ok, %Year{start_year: ^start_yr, end_year: ^end_yr}} =
               Years.create_year(%{start_year: start_yr, end_year: end_yr})
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Years.create_year(@invalid_attrs)
    end
  end

  describe "update_year/2" do
    test "with valid data updates the year" do
      year = year_fixture(start_year: 2022, end_year: 2023)
      update_attrs = %{start_year: 2024, end_year: 2025}

      assert {:ok, %Year{start_year: 2024, end_year: 2025} = updated_year} =
               Years.update_year(year, update_attrs)

      refute year == updated_year
    end

    test "with invalid data returns error changeset" do
      year = year_fixture(start_year: 2022, end_year: 2023)
      assert {:error, %Ecto.Changeset{}} = Years.update_year(year, @invalid_attrs)
      assert year == Years.get_year!(year.id)
    end
  end

  test "delete_year/1 deletes the year" do
    year = year_fixture(start_year: 2022, end_year: 2023)
    assert {:ok, %Year{}} = Years.delete_year(year)
    assert_raise Ecto.NoResultsError, fn -> Years.get_year!(year.id) end
  end

  test "change_year/1 returns a year changeset" do
    year = year_fixture(start_year: 2022, end_year: 2023)
    assert %Ecto.Changeset{} = Years.change_year(year)
  end
end
