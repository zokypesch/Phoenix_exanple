defmodule MyApp.Module do
  @moduledoc """
  The Module context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo

  alias MyApp.Module.Modul

  @doc """
  Returns the list of modules.

  ## Examples

      iex> list_modules()
      [%Modul{}, ...]

  """
  def list_modules do
    Repo.all(Modul)
  end

  @doc """
  Gets a single modul.

  Raises `Ecto.NoResultsError` if the Modul does not exist.

  ## Examples

      iex> get_modul!(123)
      %Modul{}

      iex> get_modul!(456)
      ** (Ecto.NoResultsError)

  """
  def get_modul!(id), do: Repo.get!(Modul, id)

  @doc """
  Creates a modul.

  ## Examples

      iex> create_modul(%{field: value})
      {:ok, %Modul{}}

      iex> create_modul(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_modul(attrs \\ %{}) do
    %Modul{}
    |> Modul.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a modul.

  ## Examples

      iex> update_modul(modul, %{field: new_value})
      {:ok, %Modul{}}

      iex> update_modul(modul, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_modul(%Modul{} = modul, attrs) do
    modul
    |> Modul.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Modul.

  ## Examples

      iex> delete_modul(modul)
      {:ok, %Modul{}}

      iex> delete_modul(modul)
      {:error, %Ecto.Changeset{}}

  """
  def delete_modul(%Modul{} = modul) do
    Repo.delete(modul)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking modul changes.

  ## Examples

      iex> change_modul(modul)
      %Ecto.Changeset{source: %Modul{}}

  """
  def change_modul(%Modul{} = modul) do
    Modul.changeset(modul, %{})
  end
end
