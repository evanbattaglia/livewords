defmodule Livewords.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :name, :string

    has_many :guesses, Livewords.Games.Guess
    has_many :clues, Livewords.Games.Clue

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
