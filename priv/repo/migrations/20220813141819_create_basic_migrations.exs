defmodule Sanchayika.Repo.Migrations.CreateBasicMigrations do
  use Ecto.Migration

  def up do
    create table(:student, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :total_balance, :decimal, default: 0.0, precisio: 2

      timestamps()
    end

    create table(:class, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :class_name, :string

      timestamps()
    end

    create table(:academic_year, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :start_year, :integer
      add :end_year, :integer

      timestamps()
    end

    create table(:student_class_year, primary_key: false) do
      add :student_id, references(:student, type: :uuid)
      add :class_id, references(:class, type: :uuid)
      add :academic_year_id, references(:academic_year, type: :uuid)
    end
  end

  def down do
    drop_if_exists(table(:student_class_year))
    drop_if_exists(table(:academic_year))
    drop_if_exists(table(:class))
    drop_if_exists(table(:student))
  end
end
