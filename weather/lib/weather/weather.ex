defmodule Weather.Weather do
  def fetch(city) do
    weather_url(city)
    |> HTTPoison.get()
    |> handle_response
  end

  def weather_url(city) do
    "https://w1.weather.gov/xml/current_obs/#{city}.xml"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({_, %{status_code: _, body: body}}) do
    {:error, body}
  end
end
