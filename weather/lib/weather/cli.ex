defmodule Weather.Cli do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the weather for a given city.
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns the :help
  """
  def parse_args(argv) do
    parse =
      OptionParser.parse(argv,
        switches: [help: :boolean],
        aliases: [h: :help]
      )
      |> elem(1)
      |> args_to_internal_representation()
  end

  def args_to_internal_representation([city]) when byte_size(city) != 0 do
    {city}
  end

  def args_to_internal_representation(_) do
    :help
  end

  def process(:help) do
    IO.puts("""
    usege: weather <city>
    """)
  end

  def process({city}) do
    Weather.Weather.fetch(city)
  end
end
