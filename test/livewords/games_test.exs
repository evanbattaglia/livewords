defmodule Livewords.GamesTest do
  use Livewords.DataCase

  alias Livewords.Games

  describe "games" do
    alias Livewords.Games.Game

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Games.create_game(@valid_attrs)
      assert game.name == "some name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Games.update_game(game, @update_attrs)
      assert game.name == "some updated name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "clues" do
    alias Livewords.Games.Clue

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def clue_fixture(attrs \\ %{}) do
      {:ok, clue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_clue()

      clue
    end

    test "list_clues/0 returns all clues" do
      clue = clue_fixture()
      assert Games.list_clues() == [clue]
    end

    test "get_clue!/1 returns the clue with given id" do
      clue = clue_fixture()
      assert Games.get_clue!(clue.id) == clue
    end

    test "create_clue/1 with valid data creates a clue" do
      assert {:ok, %Clue{} = clue} = Games.create_clue(@valid_attrs)
      assert clue.text == "some text"
    end

    test "create_clue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_clue(@invalid_attrs)
    end

    test "update_clue/2 with valid data updates the clue" do
      clue = clue_fixture()
      assert {:ok, %Clue{} = clue} = Games.update_clue(clue, @update_attrs)
      assert clue.text == "some updated text"
    end

    test "update_clue/2 with invalid data returns error changeset" do
      clue = clue_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_clue(clue, @invalid_attrs)
      assert clue == Games.get_clue!(clue.id)
    end

    test "delete_clue/1 deletes the clue" do
      clue = clue_fixture()
      assert {:ok, %Clue{}} = Games.delete_clue(clue)
      assert_raise Ecto.NoResultsError, fn -> Games.get_clue!(clue.id) end
    end

    test "change_clue/1 returns a clue changeset" do
      clue = clue_fixture()
      assert %Ecto.Changeset{} = Games.change_clue(clue)
    end
  end

  describe "guesses" do
    alias Livewords.Games.Guess

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def guess_fixture(attrs \\ %{}) do
      {:ok, guess} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_guess()

      guess
    end

    test "list_guesses/0 returns all guesses" do
      guess = guess_fixture()
      assert Games.list_guesses() == [guess]
    end

    test "get_guess!/1 returns the guess with given id" do
      guess = guess_fixture()
      assert Games.get_guess!(guess.id) == guess
    end

    test "create_guess/1 with valid data creates a guess" do
      assert {:ok, %Guess{} = guess} = Games.create_guess(@valid_attrs)
      assert guess.text == "some text"
    end

    test "create_guess/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_guess(@invalid_attrs)
    end

    test "update_guess/2 with valid data updates the guess" do
      guess = guess_fixture()
      assert {:ok, %Guess{} = guess} = Games.update_guess(guess, @update_attrs)
      assert guess.text == "some updated text"
    end

    test "update_guess/2 with invalid data returns error changeset" do
      guess = guess_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_guess(guess, @invalid_attrs)
      assert guess == Games.get_guess!(guess.id)
    end

    test "delete_guess/1 deletes the guess" do
      guess = guess_fixture()
      assert {:ok, %Guess{}} = Games.delete_guess(guess)
      assert_raise Ecto.NoResultsError, fn -> Games.get_guess!(guess.id) end
    end

    test "change_guess/1 returns a guess changeset" do
      guess = guess_fixture()
      assert %Ecto.Changeset{} = Games.change_guess(guess)
    end
  end
end
