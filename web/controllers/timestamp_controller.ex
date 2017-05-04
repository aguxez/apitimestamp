defmodule Timestamp.TimestampController do
  use Timestamp.Web, :controller

  def index(conn, %{"date" => date}) do
    render conn, "index.json", date: date
  end
end