defmodule MyApp.Repo.Migrations.CreatePermitions do
  use Ecto.Migration

  def change do
    create table(:permitions) do
      add :name, :string
      add :module_id, :integer
      add :perrmission_code, :string

      timestamps()
    end

  end
end
