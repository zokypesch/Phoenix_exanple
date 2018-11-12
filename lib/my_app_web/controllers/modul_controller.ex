defmodule MyAppWeb.ModulController do
  use MyAppWeb, :controller

  alias MyApp.Module
  alias MyApp.Module.Modul

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    modules = Module.list_modules()
    render(conn, "index.json", modules: modules)
  end

  def create(conn, %{"modul" => modul_params}) do
    with {:ok, %Modul{} = modul} <- Module.create_modul(modul_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", modul_path(conn, :show, modul))
      |> render("show.json", modul: modul)
    end
  end

  def show(conn, %{"id" => id}) do
    modul = Module.get_modul!(id)
    render(conn, "show.json", modul: modul)
  end

  def update(conn, %{"id" => id, "modul" => modul_params}) do
    modul = Module.get_modul!(id)

    with {:ok, %Modul{} = modul} <- Module.update_modul(modul, modul_params) do
      render(conn, "show.json", modul: modul)
    end
  end

  def delete(conn, %{"id" => id}) do
    modul = Module.get_modul!(id)
    with {:ok, %Modul{}} <- Module.delete_modul(modul) do
      send_resp(conn, :no_content, "")
    end
  end
end
