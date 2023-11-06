defmodule ColorTest do
  use ExUnit.Case
  use ColorSignal

  test "check rgb" do
    assert ~c{red} == 0xff0000
    assert ~c{green}r == 0x00ff00
  end

  test "check hsb" do
    assert ~c{red}h == {0, 100, 100}
  end
end
