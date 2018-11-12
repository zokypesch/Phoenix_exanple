defmodule MyAppWeb.RolePermView do
  use MyAppWeb, :view
  alias MyAppWeb.RolePermView

  def render("index.json", %{role_permissions: role_permissions}) do
    %{data: render_many(role_permissions, RolePermView, "role_perm.json")}
  end

  def render("show.json", %{role_perm: role_perm}) do
    %{data: render_one(role_perm, RolePermView, "role_perm.json")}
  end

  def render("role_perm.json", %{role_perm: role_perm}) do
    %{id: role_perm.id,
      role_id: role_perm.role_id,
      permission_id: role_perm.permission_id,
      user_id: role_perm.user_id}
  end
end
