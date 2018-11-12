defmodule MyApp.RolePermission.RolePerm do
  use Ecto.Schema
  import Ecto.Changeset


  schema "role_permissions" do
    field :permission_id, :integer
    field :role_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(role_perm, attrs) do
    role_perm
    |> cast(attrs, [:role_id, :permission_id, :user_id])
    |> validate_required([:role_id, :permission_id, :user_id])
  end
end
