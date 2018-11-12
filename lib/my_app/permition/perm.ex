defmodule MyApp.Permition.Perm do
  use Ecto.Schema
  import Ecto.Changeset


  schema "permitions" do
    field :module_id, :integer
    field :name, :string
    field :perrmission_code, :string

    timestamps()
  end

  @doc false
  def changeset(perm, attrs) do
    perm
    |> cast(attrs, [:name, :module_id, :perrmission_code])
    |> validate_required([:name, :module_id, :perrmission_code])
  end
end
