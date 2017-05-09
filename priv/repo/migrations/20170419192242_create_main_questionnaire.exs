defmodule Quest.Repo.Migrations.CreateQuest.Main.Questionnaire do
  use Ecto.Migration

  def change do
    create table(:main_questionnaires) do
      add :title, :string
      add :info, :string,  size: 4096
      add :status, :string
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
