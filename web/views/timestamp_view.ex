defmodule Timestamp.TimestampView do
  use Timestamp.Web, :view

  @month %{
    "january" => "01",
    "february" => "02",
    "march" => "03",
    "april" => "04",
    "may" => "05",
    "june" => "06",
    "july" => "07",
    "august" => "08",
    "september" => "09",
    "october" => "10",
    "november" => "11",
    "december" => "12"
  }

  def render("index.json", %{date: date}) do
    %{
      unix: unix_parse(date),
      natural: natural_date(date)
    }
  end

  defp unix_parse(date) do
    # just parse the date
    parsed_date =
      date
      |> String.replace(" ", "/")

    # Processing
    month_name = parsed_date |> String.split("/") |> Enum.at(0)
    {key, month_number} = Enum.find(@month, fn{key, _val} -> key == String.downcase(month_name) end)

    filter_month_name = parsed_date |> String.split("/") |> Enum.slice(-2..-1) |> Enum.join("/")

    # Convert to NaiveDate
    {_, date} = 
      Timex.parse("#{month_number}/#{filter_month_name} 01:00 AM", "{0M}/{0D}/{YYYY} {h12}:{m} {AM}")
    # Get unix timestamp
    date 
    |> DateTime.from_naive!("Etc/UTC") 
    |> DateTime.to_unix() 
    |> Integer.to_string()
  end

  defp natural_date(date) do
    date
    |> String.split(" ")
    |> Enum.map(fn date -> String.capitalize(date) end)
    |> Enum.join(", ")
  end

end