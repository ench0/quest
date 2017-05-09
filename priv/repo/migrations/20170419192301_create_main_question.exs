defmodule Quest.Repo.Migrations.CreateQuest.Main.Question do
  use Ecto.Migration

  def change do
    create table(:main_questions) do
      add :title, :string
      add :info, :string, size: 4096
      add :content, :string, size: 4096
      add :order, :integer
      add :type, :string
      add :required, :boolean, default: false, null: false
      add :inline, :boolean, default: false, null: false
      add :questionnaire_id, references(:main_questionnaires, on_delete: :delete_all)

      timestamps()
    end

    create index(:main_questions, [:questionnaire_id])
  end
end
