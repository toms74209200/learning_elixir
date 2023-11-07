defmodule CsvSigil do

  def sigil_v(csv, []), do: _v(csv)

  defp _v(csv) do
    String.split(csv, "\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, ",")
    end)
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [sigil_v: 2]
      import unquote(__MODULE__), only: [sigil_v: 2]
    end
  end
end
