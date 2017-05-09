defmodule Quest.Web.SubmissionController do
  use Quest.Web, :controller

  alias Quest.Main

  def index(conn, _params) do
    submissions = Main.list_submissions()
    render(conn, "index.html", submissions: submissions)
  end

  def new(conn, _params) do
    changeset = Main.change_submission(%Quest.Main.Submission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"submission" => submission_params}) do
    answers = Map.delete(submission_params, "questionnaire_id")
    questionnaire_id = submission_params["questionnaire_id"]
    meta = conn.req_headers
    uid = StringGenerator.string_of_length(4)
    # meta = %{meta | "uid" => uid}
    meta = Enum.into(meta, %{})

    questionnaire = Main.get_questionnaire!(questionnaire_id)

    IO.puts "+++++"
    IO.inspect submission_params
    IO.inspect questionnaire_id
    # questions = questionnaire.main_questions

    submission_params = %{ "uid" => uid, "answers" => answers, "questionnaire_id" => questionnaire_id,  "meta" => meta, "active" => false}

    IO.puts "+++++"
    IO.inspect submission_params

    case Main.create_submission(submission_params) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, "Submission created successfully.")
        |> redirect(to: submission_path(conn, :show, uid))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"uid" => uid}) do
    # start stopwatch
    start = Timex.now

    # IO.puts "+++++"
    # IO.inspect questions

    case submission = Main.get_submission_by(uid) do
      nil ->
        conn
        |> put_flash(:info, "Submission not found.")
        |> redirect(to: page_path(conn, :index))
      _ ->
        questions = Main.list_questions_of(submission.questionnaire_id)
        questions = Enum.map(questions, fn(x)-> {
                                                  x.title,
                                                  x.type,
                                                  Map.get(submission.answers, Integer.to_string(x.id))
                                                } end)
        IO.puts "+++++"
        # IO.inspect submission
        IO.inspect questions
        IO.inspect submission.answers
        finish = Timex.now
        dur = Timex.diff(finish, start, :milliseconds)
        render(conn, "show.html", submission: submission, dur: dur, questions: questions)
    end
    # render(conn, "show.html", submission: submission)
  end

  def edit(conn, %{"id" => id}) do
    submission = Main.get_submission!(id)
    changeset = Main.change_submission(submission)
    render(conn, "edit.html", submission: submission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "submission" => submission_params}) do
    submission = Main.get_submission!(id)

    case Main.update_submission(submission, submission_params) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, "Submission updated successfully.")
        |> redirect(to: submission_path(conn, :show, submission))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", submission: submission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    submission = Main.get_submission!(id)
    {:ok, _submission} = Main.delete_submission(submission)

    conn
    |> put_flash(:info, "Submission deleted successfully.")
    |> redirect(to: submission_path(conn, :index))
  end
end
