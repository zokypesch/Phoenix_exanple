defmodule MyAppWeb.PermCodeController do
  use MyAppWeb, :controller

  alias MyApp.PermitionCode
  alias MyApp.PermitionCode.PermCode

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    permition_codes = PermitionCode.list_permition_codes()
    render(conn, "index.json", permition_codes: permition_codes)
  end

  def create(conn, %{"perm_code" => perm_code_params}) do
    with {:ok, %PermCode{} = perm_code} <- PermitionCode.create_perm_code(perm_code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", perm_code_path(conn, :show, perm_code))
      |> render("show.json", perm_code: perm_code)
    end
  end

  def show(conn, %{"id" => id}) do
    perm_code = PermitionCode.get_perm_code!(id)
    render(conn, "show.json", perm_code: perm_code)
  end

  def update(conn, %{"id" => id, "perm_code" => perm_code_params}) do
    perm_code = PermitionCode.get_perm_code!(id)

    with {:ok, %PermCode{} = perm_code} <- PermitionCode.update_perm_code(perm_code, perm_code_params) do
      render(conn, "show.json", perm_code: perm_code)
    end
  end

  def delete(conn, %{"id" => id}) do
    perm_code = PermitionCode.get_perm_code!(id)
    with {:ok, %PermCode{}} <- PermitionCode.delete_perm_code(perm_code) do
      send_resp(conn, :no_content, "")
    end
  end
end
