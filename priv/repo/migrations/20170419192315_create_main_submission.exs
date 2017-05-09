defmodule Quest.Repo.Migrations.CreateQuest.Main.Submission do
  use Ecto.Migration

  def change do
    create table(:main_submissions) do
      add :answers, :map
      add :meta, :map
      add :questionnaire_id, references(:main_questionnaires, on_delete: :nothing)
      add :active, :boolean, default: false, null: false
      add :uid, :string

      timestamps()
    end

    create index(:main_submissions, [:questionnaire_id])
  end
end
