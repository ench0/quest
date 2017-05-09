defmodule Quest.Repo.Migrations.CreateQuest.Main.Option do
  use Ecto.Migration

  def change do
    create table(:main_options) do
      add :title, :string
      add :order, :integer
      add :question_id, references(:main_questions, on_delete: :delete_all)

      timestamps()
    end

    create index(:main_options, [:question_id])
  end
end
