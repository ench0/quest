defmodule Quest.Repo.Migrations.AddActiveToSubmission do
  use Ecto.Migration

  def change do
    alter table(:main_submissions) do
      add :active, :boolean, default: false, null: false
    end
  end
end
