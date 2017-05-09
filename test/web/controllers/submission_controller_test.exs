defmodule Quest.Web.SubmissionControllerTest do
  use Quest.Web.ConnCase

  alias Quest.Main

  @create_attrs %{answers: %{}, meta: %{}}
  @update_attrs %{answers: %{}, meta: %{}}
  @invalid_attrs %{answers: nil, meta: nil}

  def fixture(:submission) do
    {:ok, submission} = Main.create_submission(@create_attrs)
    submission
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, submission_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Submissions"
  end

  test "renders form for new submissions", %{conn: conn} do
    conn = get conn, submission_path(conn, :new)
    assert html_response(conn, 200) =~ "New Submission"
  end

  test "creates submission and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, submission_path(conn, :create), submission: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == submission_path(conn, :show, id)

    conn = get conn, submission_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Submission"
  end

  test "does not create submission and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, submission_path(conn, :create), submission: @invalid_attrs
    assert html_response(conn, 200) =~ "New Submission"
  end

  test "renders form for editing chosen submission", %{conn: conn} do
    submission = fixture(:submission)
    conn = get conn, submission_path(conn, :edit, submission)
    assert html_response(conn, 200) =~ "Edit Submission"
  end

  test "updates chosen submission and redirects when data is valid", %{conn: conn} do
    submission = fixture(:submission)
    conn = put conn, submission_path(conn, :update, submission), submission: @update_attrs
    assert redirected_to(conn) == submission_path(conn, :show, submission)

    conn = get conn, submission_path(conn, :show, submission)
    assert html_response(conn, 200)
  end

  test "does not update chosen submission and renders errors when data is invalid", %{conn: conn} do
    submission = fixture(:submission)
    conn = put conn, submission_path(conn, :update, submission), submission: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Submission"
  end

  test "deletes chosen submission", %{conn: conn} do
    submission = fixture(:submission)
    conn = delete conn, submission_path(conn, :delete, submission)
    assert redirected_to(conn) == submission_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, submission_path(conn, :show, submission)
    end
  end
end
