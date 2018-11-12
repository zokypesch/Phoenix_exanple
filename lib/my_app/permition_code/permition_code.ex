defmodule MyApp.PermitionCode do
  @moduledoc """
  The PermitionCode context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo

  alias MyApp.PermitionCode.PermCode

  @doc """
  Returns the list of permition_codes.

  ## Examples

      iex> list_permition_codes()
      [%PermCode{}, ...]

  """
  def list_permition_codes do
    Repo.all(PermCode)
  end

  @doc """
  Gets a single perm_code.

  Raises `Ecto.NoResultsError` if the Perm code does not exist.

  ## Examples

      iex> get_perm_code!(123)
      %PermCode{}

      iex> get_perm_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perm_code!(id), do: Repo.get!(PermCode, id)

  @doc """
  Creates a perm_code.

  ## Examples

      iex> create_perm_code(%{field: value})
      {:ok, %PermCode{}}

      iex> create_perm_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perm_code(attrs \\ %{}) do
    %PermCode{}
    |> PermCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perm_code.

  ## Examples

      iex> update_perm_code(perm_code, %{field: new_value})
      {:ok, %PermCode{}}

      iex> update_perm_code(perm_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perm_code(%PermCode{} = perm_code, attrs) do
    perm_code
    |> PermCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PermCode.

  ## Examples

      iex> delete_perm_code(perm_code)
      {:ok, %PermCode{}}

      iex> delete_perm_code(perm_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perm_code(%PermCode{} = perm_code) do
    Repo.delete(perm_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perm_code changes.

  ## Examples

      iex> change_perm_code(perm_code)
      %Ecto.Changeset{source: %PermCode{}}

  """
  def change_perm_code(%PermCode{} = perm_code) do
    PermCode.changeset(perm_code, %{})
  end
end
