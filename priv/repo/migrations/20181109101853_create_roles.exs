defmodule MyApp.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :display_name, :text

      timestamps()
    end

  end
end
