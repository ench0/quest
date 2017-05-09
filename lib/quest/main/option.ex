defmodule Quest.Main.Option do
  use Ecto.Schema

  schema "main_options" do
    field :order, :integer
    field :title, :string
    # field :main_question_id, :id

    belongs_to :main_question, Main.Question, foreign_key: :question_id

    timestamps()
  end
end
