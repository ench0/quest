defmodule Quest.Repo.Migrations.AddContentToQuestions do
  use Ecto.Migration

  def change do
    alter table(:main_questions) do
      add :content, :string, size: 4096
    end
  end
end
