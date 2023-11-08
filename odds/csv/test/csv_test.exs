defmodule CsvTest do
  use ExUnit.Case
  use CsvSigil

  test "check csv" do
    assert ~v"""
           1, 2, 3
           cat, dog
           """ == [[1.0, 2.0, 3.0], ["cat", "dog"]]
  end

  test "check float" do
    assert ~v"""
           1.0, 2.0, 3.14
           cat, dog
           """ == [[1.0, 2.0, 3.14], ["cat", "dog"]]
  end
end
