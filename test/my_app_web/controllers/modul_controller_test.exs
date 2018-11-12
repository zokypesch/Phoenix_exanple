defmodule MyAppWeb.ModulControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.Module
  alias MyApp.Module.Modul

  @create_attrs %{display_name: "some display_name", name: "some name"}
  @update_attrs %{display_name: "some updated display_name", name: "some updated name"}
  @invalid_attrs %{display_name: nil, name: nil}

  def fixture(:modul) do
    {:ok, modul} = Module.create_modul(@create_attrs)
    modul
  end

  setup %{conn: conn} do
    {:ok, conn: conn, current_user: current_user} = MyApp.Auth.Test.setup_current_user(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), current_user: current_user}
  end

  describe "index" do
    test "lists all modules", %{conn: conn} do
      conn = get conn, modul_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create modul" do
    test "renders modul when data is valid", %{conn: conn} do
      conn = post conn, modul_path(conn, :create), modul: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, modul_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "display_name" => "some display_name",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, modul_path(conn, :create), modul: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update modul" do
    setup [:create_modul]

    test "renders modul when data is valid", %{conn: conn, modul: %Modul{id: id} = modul} do
      conn = put conn, modul_path(conn, :update, modul), modul: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, modul_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "display_name" => "some updated display_name",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, modul: modul} do
      conn = put conn, modul_path(conn, :update, modul), modul: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete modul" do
    setup [:create_modul]

    test "deletes chosen modul", %{conn: conn, modul: modul} do
      conn = delete conn, modul_path(conn, :delete, modul)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, modul_path(conn, :show, modul)
      end
    end
  end

  defp create_modul(_) do
    modul = fixture(:modul)
    {:ok, modul: modul}
  end
end
