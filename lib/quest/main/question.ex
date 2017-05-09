defmodule Quest.Main.Question do
  use Ecto.Schema

  schema "main_questions" do
    field :info, :string
    field :content, :string
    field :inline, :boolean, default: false
    field :order, :integer
    field :required, :boolean, default: false
    field :title, :string
    field :type, :string
    field :active, :boolean, default: true

    # field :main_questionnaire_id, :id

    has_many :main_options, Quest.Main.Option, on_delete: :delete_all
    belongs_to :main_questionnaire, Main.Questionnaire, foreign_key: :questionnaire_id

    timestamps()
  end
end
