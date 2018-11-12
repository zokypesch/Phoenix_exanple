defmodule MyAppWeb.ModulView do
  use MyAppWeb, :view
  alias MyAppWeb.ModulView

  def render("index.json", %{modules: modules}) do
    %{data: render_many(modules, ModulView, "modul.json")}
  end

  def render("show.json", %{modul: modul}) do
    %{data: render_one(modul, ModulView, "modul.json")}
  end

  def render("modul.json", %{modul: modul}) do
    %{id: modul.id,
      name: modul.name,
      display_name: modul.display_name}
  end
end
