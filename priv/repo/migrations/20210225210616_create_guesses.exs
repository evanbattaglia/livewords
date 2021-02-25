defmodule Livewords.Repo.Migrations.CreateGuesses do
  use Ecto.Migration

  def change do
    create table(:guesses) do
      add :text, :string
      add :game_id, references(:games, on_delete: :delete_all)

      timestamps()
    end

    create index(:guesses, [:game_id])
  end
end
