defmodule Quest.PageHelper do
      alias Quest.Repo
      alias Quest.Static.Page
      import Ecto.Query

  def pages_menu do
    query = from(s in Page, order_by: s.order)
    pages = Repo.all(query)

    pages = Enum.filter_map(pages, fn(x) -> 
            if x.active && x.menu do
              x
            end
          end, &([&1.title, &1.slug]))
          # IO.inspect pages
  end


  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "pure-menu-selected"
    else
      nil
    end
  end

  def edit_link(conn) do
    edit_path = Path.join(["/", conn.path_info, "edit"])
  end





  def active_link(conn, path, opts) do
    class = [opts[:class], active_class(conn, path)]
            |> Enum.filter(& &1) 
            |> Enum.join(" ")
    opts = opts
          |> Keyword.put(:class, class)
          |> Keyword.put(:to, path)
    # link text, opts
  end


end