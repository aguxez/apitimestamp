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
    map_response(date)
  end

  defp map_response(date) do
    if valid_date?(date) do
      %{
        unix: valid_date?(date),
        natural: natural_date(date)
      }
    else
      %{
        unix: valid_date?(date),
        natural: nil
      }
    end
  end

  defp natural_date(date) do
    date
    |> String.split(" ")
    |> Enum.map(fn date -> String.capitalize(date) end)
    |> Enum.join(", ")      
  end

  defp valid_date?(date) do
    # just parse the date
    parsed_date =
      date
      |> String.replace(" ", "/")

    # Processing
    month_name = parsed_date |> String.split("/") |> Enum.at(0)
    # {key, month_number} = Enum.find(@month, fn{key, _val} -> key == String.downcase(month_name) end)

    case Enum.find(@month, fn{key, _val} -> key == String.downcase(month_name) end) do
      {key, month_number} ->
        filter_month_name = parsed_date |> String.split("/") |> Enum.slice(-2..-1) |> Enum.join("/")

        # Convert to NaiveDate and get unix timestamp
        case Timex.parse("#{month_number}/#{filter_month_name} 01:00 AM", "{0M}/{0D}/{YYYY} {h12}:{m} {AM}") do
          {:ok, struct} ->
            struct
            |> DateTime.from_naive!("Etc/UTC") 
            |> DateTime.to_unix() 
            |> Integer.to_string()
          {:error, _reason} ->
            nil
        end
      _ ->
        nil
    end
  end
end