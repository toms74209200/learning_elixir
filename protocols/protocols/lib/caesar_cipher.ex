defprotocol CaesarCipher do
  @fallback_to_any true
  def encrypt(string, shift)
  def rot13(string)
end

defimpl CaesarCipher, for: BitString do
  def encrypt(string, shift) do
    string
    |> String.upcase()
    |> String.codepoints()
    |> Enum.map(fn codepoint ->
      <<n>> = codepoint
      shift(n, shift)
    end)
    |> Enum.map(fn codepoint ->
      List.to_string([codepoint])
    end)
    |> Enum.join()
  end

  def rot13(string) do
    encrypt(string, 13)
  end

  defp shift(n, shift) when n in ?A..?Z do
    rem(n - ?A + shift, ?A - ?Z - 1) + ?A
  end

  defp shift(n, _), do: n
end
