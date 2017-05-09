defmodule Quest.Main.Questionnaire do
  use Ecto.Schema

  schema "main_questionnaires" do
    field :info, :string
    field :status, :string
    field :tags, {:array, :string}
    field :title, :string

    has_many :main_questions, Main.Question, on_delete: :delete_all
    # has_many :main_options, through: [:main_questions, :main_options]

    timestamps()
  end
end
