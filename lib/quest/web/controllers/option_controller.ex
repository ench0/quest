defmodule Quest.Web.OptionController do
  use Quest.Web, :controller

  alias Quest.Main

  def index(conn, _params) do
    options = Main.list_options()
    render(conn, "index.html", options: options)
  end

  def new(conn, option_params) do
    questions = Main.list_questions()
    question_id = option_params["question_id"]

    question_list = Enum.map(questions, fn(x)-> ["#{x.title}": "#{Integer.to_string(x.id)}"] end)
      |> List.flatten

    changeset = Main.change_option(%Quest.Main.Option{})
    render(conn, "new.html", changeset: changeset, question_list: question_list, question_id: question_id)
  end

  def create(conn, %{"option" => option_params}) do
    questions = Main.list_questions()
    question_id = option_params["question_id"]
    questions_list = Enum.map(questions, fn(x)-> ["#{x.title}": "#{Integer.to_string(x.id)}"] end)
      |> List.flatten 

    case Main.create_option(option_params) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option created successfully.")
        |> redirect(to: question_path(conn, :edit, question_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, questions_list: questions_list, question_id: question_id)
    end
  end

  def show(conn, %{"id" => id}) do
    option = Main.get_option!(id)
    render(conn, "show.html", option: option)
  end

  def edit(conn, option_params) do
    id = option_params["id"]
    question_id = option_params["question_id"]
    option = Main.get_option!(id)
    questions = Main.list_questions()
    question = Main.get_question!(option.question_id)
    questions_list = Enum.map(questions, fn(x)-> ["#{x.title}": "#{Integer.to_string(x.id)}"] end)
      |> List.flatten

    changeset = Main.change_option(option)
    render(conn, "edit.html", option: option, changeset: changeset, questions_list: questions_list, question: question, question_id: question_id)
  end

  def update(conn, %{"id" => id, "option" => option_params}) do
    option = Main.get_option!(id)
    questions = Main.list_questions()
    question = Main.get_question!(option.question_id)
    questions_list = Enum.map(questions, fn(x)-> ["#{x.title}": "#{Integer.to_string(x.id)}"] end)
      |> List.flatten

    case Main.update_option(option, option_params) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option updated successfully.")
        |> redirect(to: question_path(conn, :edit, question.id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", option: option, changeset: changeset, questions_list: questions_list, question: question)
    end
  end

  def delete(conn, %{"id" => id}) do
    option = Main.get_option!(id)
    {:ok, _option} = Main.delete_option(option)

    conn
    |> put_flash(:info, "Option deleted successfully.")
    |> redirect(to: option_path(conn, :index))
  end
end
