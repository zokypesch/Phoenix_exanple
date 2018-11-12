defmodule MyApp.Repo.Migrations.CreateModules do
  use Ecto.Migration

  def change do
    create table(:modules) do
      add :name, :string
      add :display_name, :text

      timestamps()
    end

  end
end
