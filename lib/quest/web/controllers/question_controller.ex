defmodule Quest.Web.QuestionController do
  use Quest.Web, :controller

  alias Quest.Main

  def index(conn, _params) do
    questions = Main.list_questions()
    render(conn, "index.html", questions: questions)
  end

  def new(conn, question_params) do
    questionnaires = Main.list_questionnaires()
    questionnaire_id = question_params["questionnaire_id"]

    # questionnaire = Main.get_questionnaire!(question.questionnaire_id)
    questionnaires_list = Enum.map(questionnaires, fn(x)-> ["#{x.title}": "#{Integer.to_string(x.id)}"] end)
      |> List.flatten

    lastquestion = Main.get_latest_question(questionnaire_id)
    if lastquestion do orderdefault = lastquestion.order + 1 else orderdefault = 0 end
    # IO.puts "+++"
    # IO.inspect orderdefault

    changeset = Main.change_question(%Quest.Main.Question{})
    render(conn, "new.html", changeset: changeset, questionnaires_list: questionnaires_list, questionnaire_id: questionnaire_id, orderdefault: orderdefault)
  end

  def create(conn, %{"question" => question_params}) do
    questionnaires = Main.list_questionnaires()
    questionnaire_id = question_params["questionnaire_id"]
    questionnaires_list = Enum.map(questionnaires, fn(x)-> ["#{x.title}": "#{Integer.to_string(x.id)}"] end)
      |> List.flatten

    lastquestion = Main.get_latest_question(questionnaire_id)
    orderdefault = lastquestion.order + 1

    # IO.puts "+++"
    # IO.inspect question_params

    case Main.create_question(question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: questionnaire_path(conn, :edit, questionnaire_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts "+++"
        IO.inspect changeset
        render(conn, "new.html", changeset: changeset, questionnaires_list: questionnaires_list, questionnaire_id: questionnaire_id, orderdefault: orderdefault)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Main.get_question!(id)
    render(conn, "show.html", question: question)
  end

  def edit(conn, question_params) do
    id = question_params["id"]
    questionnaire_id = question_params["questionnaire_id"]
    question = Main.get_question!(id)
    questionnaires = Main.list_questionnaires()
    questionnaire = Main.get_questionnaire!(question.questionnaire_id)
    questionnaires_list = Enum.map(questionnaires, fn(x)-> ["#{x.title}": "#{Integer.to_string(x.id)}"] end)
      |> List.flatten

    orderdefault = question.order
    # IO.puts "+++"
    # IO.inspect orderdefault

    form = true

    changeset = Main.change_question(question)
    render(conn, "edit.html", question: question, questionnaires_list: questionnaires_list, questionnaire: questionnaire, changeset: changeset, questionnaire_id: questionnaire_id, orderdefault: orderdefault, form: form)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Main.get_question!(id)
    questionnaires = Main.list_questionnaires()
    questionnaire = Main.get_questionnaire!(question.questionnaire_id)
    questionnaires_list = Enum.map(questionnaires, fn(x)-> ["#{x.title}": "#{Integer.to_string(x.id)}"] end)
      |> List.flatten

    case Main.update_question(question, question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: questionnaire_path(conn, :edit, questionnaire.id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", question: question, questionnaires_list: questionnaires_list, questionnaire: questionnaire, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Main.get_question!(id)
    questionnaire = Main.get_questionnaire!(question.questionnaire_id)
    {:ok, _question} = Main.delete_question(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: questionnaire_path(conn, :edit, questionnaire.id))
  end
end
