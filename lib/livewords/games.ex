defmodule Livewords.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Livewords.Repo

  alias Livewords.Games.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  alias Livewords.Games.Clue

  @doc """
  Returns the list of clues.

  ## Examples

      iex> list_clues()
      [%Clue{}, ...]

  """
  def list_clues do
    Repo.all(Clue)
  end

  @doc """
  Gets a single clue.

  Raises `Ecto.NoResultsError` if the Clue does not exist.

  ## Examples

      iex> get_clue!(123)
      %Clue{}

      iex> get_clue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clue!(id), do: Repo.get!(Clue, id)

  @doc """
  Creates a clue.

  ## Examples

      iex> create_clue(%{field: value})
      {:ok, %Clue{}}

      iex> create_clue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clue(attrs \\ %{}) do
    %Clue{}
    |> Clue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clue.

  ## Examples

      iex> update_clue(clue, %{field: new_value})
      {:ok, %Clue{}}

      iex> update_clue(clue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clue(%Clue{} = clue, attrs) do
    clue
    |> Clue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clue.

  ## Examples

      iex> delete_clue(clue)
      {:ok, %Clue{}}

      iex> delete_clue(clue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clue(%Clue{} = clue) do
    Repo.delete(clue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clue changes.

  ## Examples

      iex> change_clue(clue)
      %Ecto.Changeset{data: %Clue{}}

  """
  def change_clue(%Clue{} = clue, attrs \\ %{}) do
    Clue.changeset(clue, attrs)
  end

  alias Livewords.Games.Guess

  @doc """
  Returns the list of guesses.

  ## Examples

      iex> list_guesses()
      [%Guess{}, ...]

  """
  def list_guesses do
    Repo.all(Guess)
  end

  @doc """
  Gets a single guess.

  Raises `Ecto.NoResultsError` if the Guess does not exist.

  ## Examples

      iex> get_guess!(123)
      %Guess{}

      iex> get_guess!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guess!(id), do: Repo.get!(Guess, id)

  @doc """
  Creates a guess.

  ## Examples

      iex> create_guess(%{field: value})
      {:ok, %Guess{}}

      iex> create_guess(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guess(attrs \\ %{}) do
    %Guess{}
    |> Guess.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guess.

  ## Examples

      iex> update_guess(guess, %{field: new_value})
      {:ok, %Guess{}}

      iex> update_guess(guess, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guess(%Guess{} = guess, attrs) do
    guess
    |> Guess.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guess.

  ## Examples

      iex> delete_guess(guess)
      {:ok, %Guess{}}

      iex> delete_guess(guess)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guess(%Guess{} = guess) do
    Repo.delete(guess)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guess changes.

  ## Examples

      iex> change_guess(guess)
      %Ecto.Changeset{data: %Guess{}}

  """
  def change_guess(%Guess{} = guess, attrs \\ %{}) do
    Guess.changeset(guess, attrs)
  end
end
