defmodule Quest.Static.Page do
  use Ecto.Schema

  schema "static_pages" do
    field :active, :boolean, default: false
    field :body, :string
    field :menu, :boolean, default: false
    field :slug, :string
    field :title, :string
    field :questionnaire_id, :id

    has_one :main_questionnaire, Main.Questionnqire, on_delete: :nothing

    timestamps()
  end
end
