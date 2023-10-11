defmodule Anagrams.AnagramsTest do
  use ExUnit.Case

  test "can find organ anagrams" do
    Dictionary.start_link()

    Enum.map(1..4, &"words/list#{&1}.txt")
    |> WordlistLoader.load_from_files()

    assert Dictionary.anagrams_of("organ") |> Enum.sort() ==
             [
               "ronga",
               "rogan",
               "orang",
               "nagor",
               "groan",
               "grano",
               "goran",
               "argon",
               "angor"
             ]
             |> Enum.sort()
  end
end
