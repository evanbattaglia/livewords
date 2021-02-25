defmodule Livewords.Games.Clue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clues" do
    field :text, :string
    field :game_id, :id

    timestamps()
  end

  @doc false
  def changeset(clue, attrs) do
    clue
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
