defmodule Weather.Weather do
  def fetch(city) do
    weather_url(city)
    |> HTTPoison.get()
    |> handle_response
  end

  def weather_url(city) do
    "https://w1.weather.gov/xml/current_obs/#{city}.xml"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error(),
      body
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
