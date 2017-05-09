defmodule Quest.Web.QuestionControllerTest do
  use Quest.Web.ConnCase

  alias Quest.Main

  @create_attrs %{info: "some info", inline: true, order: 42, required: true, title: "some title", type: "some type"}
  @update_attrs %{info: "some updated info", inline: false, order: 43, required: false, title: "some updated title", type: "some updated type"}
  @invalid_attrs %{info: nil, inline: nil, order: nil, required: nil, title: nil, type: nil}

  def fixture(:question) do
    {:ok, question} = Main.create_question(@create_attrs)
    question
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, question_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Questions"
  end

  test "renders form for new questions", %{conn: conn} do
    conn = get conn, question_path(conn, :new)
    assert html_response(conn, 200) =~ "New Question"
  end

  test "creates question and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, question_path(conn, :create), question: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == question_path(conn, :show, id)

    conn = get conn, question_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Question"
  end

  test "does not create question and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, question_path(conn, :create), question: @invalid_attrs
    assert html_response(conn, 200) =~ "New Question"
  end

  test "renders form for editing chosen question", %{conn: conn} do
    question = fixture(:question)
    conn = get conn, question_path(conn, :edit, question)
    assert html_response(conn, 200) =~ "Edit Question"
  end

  test "updates chosen question and redirects when data is valid", %{conn: conn} do
    question = fixture(:question)
    conn = put conn, question_path(conn, :update, question), question: @update_attrs
    assert redirected_to(conn) == question_path(conn, :show, question)

    conn = get conn, question_path(conn, :show, question)
    assert html_response(conn, 200) =~ "some updated info"
  end

  test "does not update chosen question and renders errors when data is invalid", %{conn: conn} do
    question = fixture(:question)
    conn = put conn, question_path(conn, :update, question), question: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Question"
  end

  test "deletes chosen question", %{conn: conn} do
    question = fixture(:question)
    conn = delete conn, question_path(conn, :delete, question)
    assert redirected_to(conn) == question_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, question_path(conn, :show, question)
    end
  end
end
