defmodule Livewords.Games.Clue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clues" do
    field :text, :string

    belongs_to :game, Livewords.Games.Game

    timestamps()
  end

  @doc false
  def changeset(clue, attrs) do
    clue
    |> cast(attrs, [:text, :game_id])
    |> validate_required([:text, :game_id])
    |> foreign_key_constraint(:game_id)
  end
end
