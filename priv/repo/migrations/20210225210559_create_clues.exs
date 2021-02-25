defmodule Livewords.Repo.Migrations.CreateClues do
  use Ecto.Migration

  def change do
    create table(:clues) do
      add :text, :string
      add :game_id, references(:games, on_delete: :delete_all)

      timestamps()
    end

    create index(:clues, [:game_id])
  end
end
