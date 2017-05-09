defmodule Quest.Repo.Migrations.AddActiveToQuestions do
  use Ecto.Migration

  def change do
    alter table(:main_questions) do
      add :active, :boolean, default: true, null: false
    end
  end
end
