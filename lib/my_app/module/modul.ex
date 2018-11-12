defmodule MyApp.Module.Modul do
  use Ecto.Schema
  import Ecto.Changeset


  schema "modules" do
    field :display_name, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(modul, attrs) do
    modul
    |> cast(attrs, [:name, :display_name])
    |> validate_required([:name, :display_name])
  end
end
