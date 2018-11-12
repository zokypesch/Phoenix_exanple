defmodule MyApp.RolePermission do
  @moduledoc """
  The RolePermission context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo

  alias MyApp.RolePermission.RolePerm

  @doc """
  Returns the list of role_permissions.

  ## Examples

      iex> list_role_permissions()
      [%RolePerm{}, ...]

  """
  def list_role_permissions do
    Repo.all(RolePerm)
  end

  @doc """
  Gets a single role_perm.

  Raises `Ecto.NoResultsError` if the Role perm does not exist.

  ## Examples

      iex> get_role_perm!(123)
      %RolePerm{}

      iex> get_role_perm!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role_perm!(id), do: Repo.get!(RolePerm, id)

  @doc """
  Creates a role_perm.

  ## Examples

      iex> create_role_perm(%{field: value})
      {:ok, %RolePerm{}}

      iex> create_role_perm(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role_perm(attrs \\ %{}) do
    %RolePerm{}
    |> RolePerm.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role_perm.

  ## Examples

      iex> update_role_perm(role_perm, %{field: new_value})
      {:ok, %RolePerm{}}

      iex> update_role_perm(role_perm, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role_perm(%RolePerm{} = role_perm, attrs) do
    role_perm
    |> RolePerm.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RolePerm.

  ## Examples

      iex> delete_role_perm(role_perm)
      {:ok, %RolePerm{}}

      iex> delete_role_perm(role_perm)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role_perm(%RolePerm{} = role_perm) do
    Repo.delete(role_perm)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role_perm changes.

  ## Examples

      iex> change_role_perm(role_perm)
      %Ecto.Changeset{source: %RolePerm{}}

  """
  def change_role_perm(%RolePerm{} = role_perm) do
    RolePerm.changeset(role_perm, %{})
  end
end
