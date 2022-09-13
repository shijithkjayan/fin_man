defmodule Sanchayika.Repo.Migrations.AddUniqueIndexForYears do
  use Ecto.Migration

  def change do
    create index(:academic_year, [:start_year, :end_year], unique: true, name: "year_unique_index")
  end
end
