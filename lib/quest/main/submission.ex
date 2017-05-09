defmodule Quest.Main.Submission do
  use Ecto.Schema

  schema "main_submissions" do
    field :answers, :map
    field :meta, :map
    field :uid, :string
    # field :questionnaire_id, :id
    belongs_to :main_questionnaire, Main.Questionnaire, foreign_key: :questionnaire_id
    field :active, :boolean, default: false

    timestamps()
  end
end
