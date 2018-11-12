defmodule MyApp.Repo.Migrations.CreateRolePermissions do
  use Ecto.Migration

  def change do
    create table(:role_permissions) do
      add :role_id, :integer
      add :permission_id, :integer
      add :user_id, :integer

      timestamps()
    end

  end
end
