defmodule MyApp.PermitionCode.PermCode do
  use Ecto.Schema
  import Ecto.Changeset


  schema "permition_codes" do
    field :description, :string
    field :perrmission_code, :string

    timestamps()
  end

  @doc false
  def changeset(perm_code, attrs) do
    perm_code
    |> cast(attrs, [:perrmission_code, :description])
    |> validate_required([:perrmission_code, :description])
  end
end
