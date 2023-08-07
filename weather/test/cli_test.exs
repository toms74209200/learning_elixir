defmodule CliTest do
  use ExUnit.Case
  doctest Weather
  import Weather.Cli, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test ":help returned by given arguments are empty" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test "city returned if it given" do
    assert parse_args(["KDTO"]) == {"KDTO"}
  end
end
