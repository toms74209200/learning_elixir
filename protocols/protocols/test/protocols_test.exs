defmodule ProtocolsTest do
  use ExUnit.Case

  test "check type" do
    assert Collection.is_collection?(1) == false
    assert Collection.is_collection?(1.0) == false
    assert Collection.is_collection?([1, 2]) == true
    assert Collection.is_collection?({1, 2}) == true
    assert Collection.is_collection?(%{}) == true
    assert Collection.is_collection?("cat") == true
  end
end
