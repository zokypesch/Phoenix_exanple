defmodule MyAppWeb.PermController do
  use MyAppWeb, :controller

  alias MyApp.Permition
  alias MyApp.Permition.Perm

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    permitions = Permition.list_permitions()
    render(conn, "index.json", permitions: permitions)
  end

  def create(conn, %{"perm" => perm_params}) do
    with {:ok, %Perm{} = perm} <- Permition.create_perm(perm_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", perm_path(conn, :show, perm))
      |> render("show.json", perm: perm)
    end
  end

  def show(conn, %{"id" => id}) do
    perm = Permition.get_perm!(id)
    render(conn, "show.json", perm: perm)
  end

  def update(conn, %{"id" => id, "perm" => perm_params}) do
    perm = Permition.get_perm!(id)

    with {:ok, %Perm{} = perm} <- Permition.update_perm(perm, perm_params) do
      render(conn, "show.json", perm: perm)
    end
  end

  def delete(conn, %{"id" => id}) do
    perm = Permition.get_perm!(id)
    with {:ok, %Perm{}} <- Permition.delete_perm(perm) do
      send_resp(conn, :no_content, "")
    end
  end
end
