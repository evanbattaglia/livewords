defmodule Livewords.Games.Guess do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guesses" do
    field :text, :string

    belongs_to :game, Livewords.Games.Game

    timestamps()
  end

  @doc false
  def changeset(guess, attrs) do
    guess
    |> cast(attrs, [:text, :game_id])
    |> validate_required([:text, :game_id])
    |> foreign_key_constraint(:game_id)
  end
end
