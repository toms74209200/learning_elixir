defmodule Duper.PathFinderTest do
  use ExUnit.Case
  alias Duper.PathFinder

  test "next path is not empty string" do
    assert PathFinder.next_path() =~ ~r{.+}
  end
end
