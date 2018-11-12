defmodule MyApp.PermitionTest do
  use MyApp.DataCase

  alias MyApp.Permition

  describe "permitions" do
    alias MyApp.Permition.Perm

    @valid_attrs %{module_id: 42, name: "some name", perrmission_code: "some perrmission_code"}
    @update_attrs %{module_id: 43, name: "some updated name", perrmission_code: "some updated perrmission_code"}
    @invalid_attrs %{module_id: nil, name: nil, perrmission_code: nil}

    def perm_fixture(attrs \\ %{}) do
      {:ok, perm} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Permition.create_perm()

      perm
    end

    test "list_permitions/0 returns all permitions" do
      perm = perm_fixture()
      assert Permition.list_permitions() == [perm]
    end

    test "get_perm!/1 returns the perm with given id" do
      perm = perm_fixture()
      assert Permition.get_perm!(perm.id) == perm
    end

    test "create_perm/1 with valid data creates a perm" do
      assert {:ok, %Perm{} = perm} = Permition.create_perm(@valid_attrs)
      assert perm.module_id == 42
      assert perm.name == "some name"
      assert perm.perrmission_code == "some perrmission_code"
    end

    test "create_perm/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Permition.create_perm(@invalid_attrs)
    end

    test "update_perm/2 with valid data updates the perm" do
      perm = perm_fixture()
      assert {:ok, perm} = Permition.update_perm(perm, @update_attrs)
      assert %Perm{} = perm
      assert perm.module_id == 43
      assert perm.name == "some updated name"
      assert perm.perrmission_code == "some updated perrmission_code"
    end

    test "update_perm/2 with invalid data returns error changeset" do
      perm = perm_fixture()
      assert {:error, %Ecto.Changeset{}} = Permition.update_perm(perm, @invalid_attrs)
      assert perm == Permition.get_perm!(perm.id)
    end

    test "delete_perm/1 deletes the perm" do
      perm = perm_fixture()
      assert {:ok, %Perm{}} = Permition.delete_perm(perm)
      assert_raise Ecto.NoResultsError, fn -> Permition.get_perm!(perm.id) end
    end

    test "change_perm/1 returns a perm changeset" do
      perm = perm_fixture()
      assert %Ecto.Changeset{} = Permition.change_perm(perm)
    end
  end
end
