defmodule MyApp.PermitionCodeTest do
  use MyApp.DataCase

  alias MyApp.PermitionCode

  describe "permition_codes" do
    alias MyApp.PermitionCode.PermCode

    @valid_attrs %{description: "some description", perrmission_code: "some perrmission_code"}
    @update_attrs %{description: "some updated description", perrmission_code: "some updated perrmission_code"}
    @invalid_attrs %{description: nil, perrmission_code: nil}

    def perm_code_fixture(attrs \\ %{}) do
      {:ok, perm_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PermitionCode.create_perm_code()

      perm_code
    end

    test "list_permition_codes/0 returns all permition_codes" do
      perm_code = perm_code_fixture()
      assert PermitionCode.list_permition_codes() == [perm_code]
    end

    test "get_perm_code!/1 returns the perm_code with given id" do
      perm_code = perm_code_fixture()
      assert PermitionCode.get_perm_code!(perm_code.id) == perm_code
    end

    test "create_perm_code/1 with valid data creates a perm_code" do
      assert {:ok, %PermCode{} = perm_code} = PermitionCode.create_perm_code(@valid_attrs)
      assert perm_code.description == "some description"
      assert perm_code.perrmission_code == "some perrmission_code"
    end

    test "create_perm_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PermitionCode.create_perm_code(@invalid_attrs)
    end

    test "update_perm_code/2 with valid data updates the perm_code" do
      perm_code = perm_code_fixture()
      assert {:ok, perm_code} = PermitionCode.update_perm_code(perm_code, @update_attrs)
      assert %PermCode{} = perm_code
      assert perm_code.description == "some updated description"
      assert perm_code.perrmission_code == "some updated perrmission_code"
    end

    test "update_perm_code/2 with invalid data returns error changeset" do
      perm_code = perm_code_fixture()
      assert {:error, %Ecto.Changeset{}} = PermitionCode.update_perm_code(perm_code, @invalid_attrs)
      assert perm_code == PermitionCode.get_perm_code!(perm_code.id)
    end

    test "delete_perm_code/1 deletes the perm_code" do
      perm_code = perm_code_fixture()
      assert {:ok, %PermCode{}} = PermitionCode.delete_perm_code(perm_code)
      assert_raise Ecto.NoResultsError, fn -> PermitionCode.get_perm_code!(perm_code.id) end
    end

    test "change_perm_code/1 returns a perm_code changeset" do
      perm_code = perm_code_fixture()
      assert %Ecto.Changeset{} = PermitionCode.change_perm_code(perm_code)
    end
  end
end
