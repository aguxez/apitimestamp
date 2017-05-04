defmodule Timestamp.Router do
  use Timestamp.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Timestamp do
    pipe_through :api

    get "/:date", TimestampController, :index
  end
end
