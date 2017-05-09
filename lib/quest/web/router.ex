defmodule Quest.Web.Router do
  use Quest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/questionnaires", Quest.Web do
    pipe_through :browser # Use the default browser stack

    resources "/", QuestionnaireController
  end

  scope "/questions", Quest.Web do
    pipe_through :browser # Use the default browser stack

    resources "/", QuestionController
  end

  scope "/options", Quest.Web do
    pipe_through :browser # Use the default browser stack

    resources "/", OptionController
  end

  scope "/submissions", Quest.Web do
    pipe_through :browser # Use the default browser stack

    get "/:uid", SubmissionController, :show
    resources "/", SubmissionController
  end
  
  scope "/", Quest.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/new", PageController, :new
    get "/:slug", PageController, :show
    resources "/", PageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Quest.Web do
  #   pipe_through :api
  # end
end
