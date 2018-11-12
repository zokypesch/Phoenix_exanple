defmodule MyAppWeb.PermCodeControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.PermitionCode
  alias MyApp.PermitionCode.PermCode

  @create_attrs %{description: "some description", perrmission_code: "some perrmission_code"}
  @update_attrs %{description: "some updated description", perrmission_code: "some updated perrmission_code"}
  @invalid_attrs %{description: nil, perrmission_code: nil}

  def fixture(:perm_code) do
    {:ok, perm_code} = PermitionCode.create_perm_code(@create_attrs)
    perm_code
  end

  setup %{conn: conn} do
    {:ok, conn: conn, current_user: current_user} = MyApp.Auth.Test.setup_current_user(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), current_user: current_user}
  end

  describe "index" do
    test "lists all permition_codes", %{conn: conn} do
      conn = get conn, perm_code_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create perm_code" do
    test "renders perm_code when data is valid", %{conn: conn} do
      conn = post conn, perm_code_path(conn, :create), perm_code: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, perm_code_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "perrmission_code" => "some perrmission_code"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, perm_code_path(conn, :create), perm_code: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update perm_code" do
    setup [:create_perm_code]

    test "renders perm_code when data is valid", %{conn: conn, perm_code: %PermCode{id: id} = perm_code} do
      conn = put conn, perm_code_path(conn, :update, perm_code), perm_code: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, perm_code_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "perrmission_code" => "some updated perrmission_code"}
    end

    test "renders errors when data is invalid", %{conn: conn, perm_code: perm_code} do
      conn = put conn, perm_code_path(conn, :update, perm_code), perm_code: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete perm_code" do
    setup [:create_perm_code]

    test "deletes chosen perm_code", %{conn: conn, perm_code: perm_code} do
      conn = delete conn, perm_code_path(conn, :delete, perm_code)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, perm_code_path(conn, :show, perm_code)
      end
    end
  end

  defp create_perm_code(_) do
    perm_code = fixture(:perm_code)
    {:ok, perm_code: perm_code}
  end
end
