defmodule Timestamp.Router do
  use Timestamp.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Timestamp do
    pipe_through :api

    get "/:date", TimestampController, :index
  end
end
