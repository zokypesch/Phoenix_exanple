defmodule MyAppWeb.PermView do
  use MyAppWeb, :view
  alias MyAppWeb.PermView

  def render("index.json", %{permitions: permitions}) do
    %{data: render_many(permitions, PermView, "perm.json")}
  end

  def render("show.json", %{perm: perm}) do
    %{data: render_one(perm, PermView, "perm.json")}
  end

  def render("perm.json", %{perm: perm}) do
    %{id: perm.id,
      name: perm.name,
      module_id: perm.module_id,
      perrmission_code: perm.perrmission_code}
  end
end
