defmodule CsvTest do
  use ExUnit.Case
  use CsvSigil

  test "check csv" do
    assert ~v"""
    1,2,3
    cat, dog
    """ == [["1", "2", "3"], ["cat", " dog"]]
  end
end
