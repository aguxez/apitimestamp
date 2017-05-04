defmodule Timestamp.TimestampController do
  use Timestamp.Web, :controller

  def index(conn, %{"date" => date}) do
    render conn, "index.json", date: date

    {month, day, year} = String.split(date, " ")

    cond do
      day || String.to_integer(day) > 31
    end
  end
end