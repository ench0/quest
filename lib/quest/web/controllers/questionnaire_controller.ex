defmodule Quest.Web.QuestionnaireController do
  use Quest.Web, :controller

  alias Quest.Main
  import Ecto.{Query, Changeset}, warn: false
  alias Quest.Repo


  def index(conn, _params) do
    questionnaires = Main.list_questionnaires()
    render(conn, "index.html", questionnaires: questionnaires)
  end

  def new(conn, _params) do
    changeset = Main.change_questionnaire(%Quest.Main.Questionnaire{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"questionnaire" => questionnaire_params}) do
    tags = [questionnaire_params["tags"]]
    questionnaire_params = %{questionnaire_params | "tags" => tags}

    case Main.create_questionnaire(questionnaire_params) do
      {:ok, questionnaire} ->
        conn
        |> put_flash(:info, "Questionnaire created successfully.")
        |> redirect(to: questionnaire_path(conn, :show, questionnaire))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    # start stopwatch
    start = Timex.now

    # questionnaire = Repo.get!(Quest.Main.Questionnaire, id)
    # questionnaire = Repo.preload questionnaire, :main_questions

    # questionnaire = Repo.preload questionnaire, main_questions: from(q in Quest.Main.Question, order_by: [asc: q.order]) 

    questionnaire = Main.get_questionnaire!(id)
    changeset = Main.change_submission(%Quest.Main.Submission{})

    editlink = questionnaire_path(conn, :edit, id) 
    finish = Timex.now
    dur = Timex.diff(finish, start, :milliseconds)

    form = true

    render(conn, "show.html", questionnaire: questionnaire, changeset: changeset, editlink: editlink, dur: dur, form: form)
  end

  def edit(conn, %{"id" => id}) do
    questionnaire = Main.get_questionnaire!(id)
    questions = Main.list_questions_of(id)

    changeset = Main.change_questionnaire(questionnaire)
    render(conn, "edit.html", questionnaire: questionnaire, changeset: changeset, questions: questions)
  end

  def update(conn, %{"id" => id, "questionnaire" => questionnaire_params}) do
    questionnaire = Main.get_questionnaire!(id)
    tags = String.split(questionnaire_params["tags"], ",")
    questionnaire_params = %{questionnaire_params | "tags" => tags}
    questions = Main.list_questions_of(id)

    case Main.update_questionnaire(questionnaire, questionnaire_params) do
      {:ok, questionnaire} ->
        conn
        |> put_flash(:info, "Questionnaire updated successfully.")
        |> redirect(to: questionnaire_path(conn, :show, questionnaire))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", questionnaire: questionnaire, changeset: changeset, questions: questions)
    end
  end

  def delete(conn, %{"id" => id}) do
    questionnaire = Main.get_questionnaire!(id)
    {:ok, _questionnaire} = Main.delete_questionnaire(questionnaire)

    conn
    |> put_flash(:info, "Questionnaire deleted successfully.")
    |> redirect(to: questionnaire_path(conn, :index))
  end
end
