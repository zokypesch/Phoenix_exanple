defmodule MyApp.RolePermissionTest do
  use MyApp.DataCase

  alias MyApp.RolePermission

  describe "role_permissions" do
    alias MyApp.RolePermission.RolePerm

    @valid_attrs %{permission_id: 42, role_id: 42, user_id: 42}
    @update_attrs %{permission_id: 43, role_id: 43, user_id: 43}
    @invalid_attrs %{permission_id: nil, role_id: nil, user_id: nil}

    def role_perm_fixture(attrs \\ %{}) do
      {:ok, role_perm} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RolePermission.create_role_perm()

      role_perm
    end

    test "list_role_permissions/0 returns all role_permissions" do
      role_perm = role_perm_fixture()
      assert RolePermission.list_role_permissions() == [role_perm]
    end

    test "get_role_perm!/1 returns the role_perm with given id" do
      role_perm = role_perm_fixture()
      assert RolePermission.get_role_perm!(role_perm.id) == role_perm
    end

    test "create_role_perm/1 with valid data creates a role_perm" do
      assert {:ok, %RolePerm{} = role_perm} = RolePermission.create_role_perm(@valid_attrs)
      assert role_perm.permission_id == 42
      assert role_perm.role_id == 42
      assert role_perm.user_id == 42
    end

    test "create_role_perm/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RolePermission.create_role_perm(@invalid_attrs)
    end

    test "update_role_perm/2 with valid data updates the role_perm" do
      role_perm = role_perm_fixture()
      assert {:ok, role_perm} = RolePermission.update_role_perm(role_perm, @update_attrs)
      assert %RolePerm{} = role_perm
      assert role_perm.permission_id == 43
      assert role_perm.role_id == 43
      assert role_perm.user_id == 43
    end

    test "update_role_perm/2 with invalid data returns error changeset" do
      role_perm = role_perm_fixture()
      assert {:error, %Ecto.Changeset{}} = RolePermission.update_role_perm(role_perm, @invalid_attrs)
      assert role_perm == RolePermission.get_role_perm!(role_perm.id)
    end

    test "delete_role_perm/1 deletes the role_perm" do
      role_perm = role_perm_fixture()
      assert {:ok, %RolePerm{}} = RolePermission.delete_role_perm(role_perm)
      assert_raise Ecto.NoResultsError, fn -> RolePermission.get_role_perm!(role_perm.id) end
    end

    test "change_role_perm/1 returns a role_perm changeset" do
      role_perm = role_perm_fixture()
      assert %Ecto.Changeset{} = RolePermission.change_role_perm(role_perm)
    end
  end
end
