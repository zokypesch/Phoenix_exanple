defmodule MyAppWeb.PermCodeView do
  use MyAppWeb, :view
  alias MyAppWeb.PermCodeView

  def render("index.json", %{permition_codes: permition_codes}) do
    %{data: render_many(permition_codes, PermCodeView, "perm_code.json")}
  end

  def render("show.json", %{perm_code: perm_code}) do
    %{data: render_one(perm_code, PermCodeView, "perm_code.json")}
  end

  def render("perm_code.json", %{perm_code: perm_code}) do
    %{id: perm_code.id,
      perrmission_code: perm_code.perrmission_code,
      description: perm_code.description}
  end
end
