defmodule Quest.Repo.Migrations.AddUidToSubmission do
  use Ecto.Migration

  def change do
    alter table(:main_submissions) do
      add :uid, :string
    end
  end
end
