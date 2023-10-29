defmodule MidiTest do
  use ExUnit.Case

  test "check take" do
    midi = Midi.from_file("test/test.mid")
    [frame | _] = Enum.take(midi, 2)
    assert frame.type == "MThd"
  end

  test "check count" do
    midi = Midi.from_file("test/test.mid")
    assert Enum.count(midi) == 2
  end
end
