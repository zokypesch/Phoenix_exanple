defmodule MyApp.Role.Rule do
  use Ecto.Schema
  import Ecto.Changeset


  schema "roles" do
    field :display_name, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(rule, attrs) do
    rule
    |> cast(attrs, [:name, :display_name])
    |> validate_required([:name, :display_name])
  end
end
