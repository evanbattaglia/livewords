defmodule Livewords.Games.Guess do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guesses" do
    field :text, :string
    field :game_id, :id

    timestamps()
  end

  @doc false
  def changeset(guess, attrs) do
    guess
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
