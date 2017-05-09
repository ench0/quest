defmodule Quest.Repo.Migrations.CreateQuest.Static.Page do
  use Ecto.Migration

  def change do
    create table(:static_pages) do
      add :title, :string
      add :slug, :string
      add :body, :string, size: 131072
      add :menu, :boolean, default: false, null: false
      add :active, :boolean, default: false, null: false
      add :questionnaire_id, references(:main_questionnaires, on_delete: :nothing)
      add :order, :integer, default: 0

      timestamps()
    end

    create index(:static_pages, [:questionnaire_id])
  end
end
