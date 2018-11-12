defmodule MyAppWeb.RolePermController do
  use MyAppWeb, :controller

  alias MyApp.RolePermission
  alias MyApp.RolePermission.RolePerm

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    role_permissions = RolePermission.list_role_permissions()
    render(conn, "index.json", role_permissions: role_permissions)
  end

  def create(conn, %{"role_perm" => role_perm_params}) do
    with {:ok, %RolePerm{} = role_perm} <- RolePermission.create_role_perm(role_perm_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", role_perm_path(conn, :show, role_perm))
      |> render("show.json", role_perm: role_perm)
    end
  end

  def show(conn, %{"id" => id}) do
    role_perm = RolePermission.get_role_perm!(id)
    render(conn, "show.json", role_perm: role_perm)
  end

  def update(conn, %{"id" => id, "role_perm" => role_perm_params}) do
    role_perm = RolePermission.get_role_perm!(id)

    with {:ok, %RolePerm{} = role_perm} <- RolePermission.update_role_perm(role_perm, role_perm_params) do
      render(conn, "show.json", role_perm: role_perm)
    end
  end

  def delete(conn, %{"id" => id}) do
    role_perm = RolePermission.get_role_perm!(id)
    with {:ok, %RolePerm{}} <- RolePermission.delete_role_perm(role_perm) do
      send_resp(conn, :no_content, "")
    end
  end
end
