defmodule AgentDict.AgentDictTest do
  use ExUnit.Case
  alias AgentDict.Frequency

  test "count for" do
    Frequency.start_link()
    Frequency.add_word("dave")
    Frequency.add_word("was")
    Frequency.add_word("here")
    Frequency.add_word("he")
    Frequency.add_word("was")

    assert Frequency.count_for("dave") == 1
    assert Frequency.count_for("was") == 2
  end

  test "dict words contains" do
    Frequency.start_link()
    Frequency.add_word("dave")

    assert Enum.member?(Frequency.words(), "dave")

    Frequency.add_word("was")
    Frequency.add_word("here")
    Frequency.add_word("he")
    Frequency.add_word("was")

    assert Enum.member?(Frequency.words(), "he")
  end
end
