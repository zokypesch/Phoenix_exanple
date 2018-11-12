defmodule MyApp.ModuleTest do
  use MyApp.DataCase

  alias MyApp.Module

  describe "modules" do
    alias MyApp.Module.Modul

    @valid_attrs %{display_name: "some display_name", name: "some name"}
    @update_attrs %{display_name: "some updated display_name", name: "some updated name"}
    @invalid_attrs %{display_name: nil, name: nil}

    def modul_fixture(attrs \\ %{}) do
      {:ok, modul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Module.create_modul()

      modul
    end

    test "list_modules/0 returns all modules" do
      modul = modul_fixture()
      assert Module.list_modules() == [modul]
    end

    test "get_modul!/1 returns the modul with given id" do
      modul = modul_fixture()
      assert Module.get_modul!(modul.id) == modul
    end

    test "create_modul/1 with valid data creates a modul" do
      assert {:ok, %Modul{} = modul} = Module.create_modul(@valid_attrs)
      assert modul.display_name == "some display_name"
      assert modul.name == "some name"
    end

    test "create_modul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Module.create_modul(@invalid_attrs)
    end

    test "update_modul/2 with valid data updates the modul" do
      modul = modul_fixture()
      assert {:ok, modul} = Module.update_modul(modul, @update_attrs)
      assert %Modul{} = modul
      assert modul.display_name == "some updated display_name"
      assert modul.name == "some updated name"
    end

    test "update_modul/2 with invalid data returns error changeset" do
      modul = modul_fixture()
      assert {:error, %Ecto.Changeset{}} = Module.update_modul(modul, @invalid_attrs)
      assert modul == Module.get_modul!(modul.id)
    end

    test "delete_modul/1 deletes the modul" do
      modul = modul_fixture()
      assert {:ok, %Modul{}} = Module.delete_modul(modul)
      assert_raise Ecto.NoResultsError, fn -> Module.get_modul!(modul.id) end
    end

    test "change_modul/1 returns a modul changeset" do
      modul = modul_fixture()
      assert %Ecto.Changeset{} = Module.change_modul(modul)
    end
  end
end
