defmodule MyApp.Permition do
  @moduledoc """
  The Permition context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo

  alias MyApp.Permition.Perm

  @doc """
  Returns the list of permitions.

  ## Examples

      iex> list_permitions()
      [%Perm{}, ...]

  """
  def list_permitions do
    Repo.all(Perm)
  end

  @doc """
  Gets a single perm.

  Raises `Ecto.NoResultsError` if the Perm does not exist.

  ## Examples

      iex> get_perm!(123)
      %Perm{}

      iex> get_perm!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perm!(id), do: Repo.get!(Perm, id)

  @doc """
  Creates a perm.

  ## Examples

      iex> create_perm(%{field: value})
      {:ok, %Perm{}}

      iex> create_perm(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perm(attrs \\ %{}) do
    %Perm{}
    |> Perm.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perm.

  ## Examples

      iex> update_perm(perm, %{field: new_value})
      {:ok, %Perm{}}

      iex> update_perm(perm, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perm(%Perm{} = perm, attrs) do
    perm
    |> Perm.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Perm.

  ## Examples

      iex> delete_perm(perm)
      {:ok, %Perm{}}

      iex> delete_perm(perm)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perm(%Perm{} = perm) do
    Repo.delete(perm)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perm changes.

  ## Examples

      iex> change_perm(perm)
      %Ecto.Changeset{source: %Perm{}}

  """
  def change_perm(%Perm{} = perm) do
    Perm.changeset(perm, %{})
  end
end
