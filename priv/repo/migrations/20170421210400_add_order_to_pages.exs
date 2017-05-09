defmodule Quest.Repo.Migrations.AddOrderToPages do
  use Ecto.Migration

  def change do
    alter table(:static_pages) do
      add :order, :integer, default: 0
    end
  end
end
