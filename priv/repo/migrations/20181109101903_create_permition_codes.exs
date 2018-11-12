defmodule MyApp.Repo.Migrations.CreatePermitionCodes do
  use Ecto.Migration

  def change do
    create table(:permition_codes) do
      add :perrmission_code, :string
      add :description, :text

      timestamps()
    end

  end
end
