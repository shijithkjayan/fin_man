defmodule Sanchayika.Repo.Migrations.AddUniqueIndexForClassName do
  use Ecto.Migration

  def change do
    create index("class", [:class_name], unique: true, name: "class_name_unique_index")
  end
end
