defmodule MyAppWeb.RolePermControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.RolePermission
  alias MyApp.RolePermission.RolePerm

  @create_attrs %{permission_id: 42, role_id: 42, user_id: 42}
  @update_attrs %{permission_id: 43, role_id: 43, user_id: 43}
  @invalid_attrs %{permission_id: nil, role_id: nil, user_id: nil}

  def fixture(:role_perm) do
    {:ok, role_perm} = RolePermission.create_role_perm(@create_attrs)
    role_perm
  end

  setup %{conn: conn} do
    {:ok, conn: conn, current_user: current_user} = MyApp.Auth.Test.setup_current_user(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), current_user: current_user}
  end

  describe "index" do
    test "lists all role_permissions", %{conn: conn} do
      conn = get conn, role_perm_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create role_perm" do
    test "renders role_perm when data is valid", %{conn: conn} do
      conn = post conn, role_perm_path(conn, :create), role_perm: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, role_perm_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "permission_id" => 42,
        "role_id" => 42,
        "user_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, role_perm_path(conn, :create), role_perm: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update role_perm" do
    setup [:create_role_perm]

    test "renders role_perm when data is valid", %{conn: conn, role_perm: %RolePerm{id: id} = role_perm} do
      conn = put conn, role_perm_path(conn, :update, role_perm), role_perm: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, role_perm_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "permission_id" => 43,
        "role_id" => 43,
        "user_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, role_perm: role_perm} do
      conn = put conn, role_perm_path(conn, :update, role_perm), role_perm: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete role_perm" do
    setup [:create_role_perm]

    test "deletes chosen role_perm", %{conn: conn, role_perm: role_perm} do
      conn = delete conn, role_perm_path(conn, :delete, role_perm)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, role_perm_path(conn, :show, role_perm)
      end
    end
  end

  defp create_role_perm(_) do
    role_perm = fixture(:role_perm)
    {:ok, role_perm: role_perm}
  end
end
