defmodule Quest.Web.PageController do
  use Quest.Web, :controller

  alias Quest.Static

  def index(conn, _params) do
    # start stopwatch
    start = Timex.now

    pages = Static.list_pages()

    # stop stopwatch
    finish = Timex.now
    dur = Timex.diff(finish, start, :milliseconds)

    render(conn, "index.html", layout: {Quest.Web.LayoutView, "front.html"}, pages: pages, dur: dur)
  end

  def new(conn, _params) do
    changeset = Static.change_page(%Quest.Static.Page{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"page" => page_params}) do
    case Static.create_page(page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: page_path(conn, :show, page))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    # start stopwatch
    start = Timex.now

    case page = Static.get_page_by(slug) do
      nil ->
        conn
        |> put_flash(:info, "Page not found.")
        |> redirect(to: page_path(conn, :index))
      _ ->
        if page.questionnaire_id do
          questionnaire = Main.get_questionnaire!(page.questionnaire_id)
          form = true
        else
          questionnaire = nil
          form = false
        end

        editlink = page_path(conn, :edit, page.id) 

        finish = Timex.now
        dur = Timex.diff(finish, start, :milliseconds)

        render(conn, "show.html", page: page, questionnaire: questionnaire, form: form, dur: dur, editlink: editlink)
    end
  end

  def edit(conn, %{"id" => id}) do
    page = Static.get_page!(id)
    changeset = Static.change_page(page)
    render(conn, "edit.html", page: page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Static.get_page!(id)

    case Static.update_page(page, page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: page_path(conn, :show, page_params["slug"]))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", page: page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Static.get_page!(id)
    {:ok, _page} = Static.delete_page(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
