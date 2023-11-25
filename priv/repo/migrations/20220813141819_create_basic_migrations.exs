defmodule FinMan.Repo.Migrations.CreateBasicMigrations do
  use Ecto.Migration

  def up do
    create table(:user, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string
      add :encrypted_password, :string

      timestamps()
    end

    create table(:account, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:user, type: :uuid, on_delete: :nilify_all)
      add :name, :string
      add :balance, :integer, default: 0
      add :meta, :map, default: %{}

      timestamps()
    end

    create unique_index(:user, [:email])
    create unique_index(:account, [:user_id, :name])
  end

  def down do
    drop_if_exists(table(:account))
    drop_if_exists(table(:user))
  end
end
