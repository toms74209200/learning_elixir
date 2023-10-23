defmodule CaesarCipherTest do
  use ExUnit.Case

  test "check shift captal" do
    assert CaesarCipher.encrypt(
             ?A..?Z
             |> Enum.to_list()
             |> List.to_string(),
             1
           ) == "BCDEFGHIJKLMNOPQRSTUVWXYZA"
  end

  test "check shift small" do
    assert CaesarCipher.encrypt(
             ?a..?z
             |> Enum.to_list()
             |> List.to_string(),
             1
           ) == "BCDEFGHIJKLMNOPQRSTUVWXYZA"
  end

  test "check contains space" do
    assert CaesarCipher.encrypt("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", 3) ==
             "WKH TXLFN EURZQ IRA MXPSV RYHU WKH ODCB GRJ"
  end

  test "check rot13" do
    assert CaesarCipher.rot13(
             ?A..?Z
             |> Enum.to_list()
             |> List.to_string()
           ) == "NOPQRSTUVWXYZABCDEFGHIJKLM"
  end
end
