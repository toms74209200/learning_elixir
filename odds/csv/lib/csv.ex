defmodule CsvSigil do
  def sigil_v(csv, []), do: _v(csv)
  def sigil_v(csv, 'l'), do: _v(csv, :label)

  defp _v(csv) do
    String.split(csv, "\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, ",")
    end)
    |> exec_cell(fn cell ->
      String.trim(cell)
    end)
    |> exec_cell(fn cell ->
      case Float.parse(cell) do
        {float, _} -> float
        _ -> cell
      end
    end)
  end

  defp _v(csv, :label) do
    [headers | values] =
      String.split(csv, "\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, ",")
      end)
      |> exec_cell(fn cell ->
        String.trim(cell)
      end)
      |> exec_cell(fn cell ->
        case Float.parse(cell) do
          {float, _} -> float
          _ -> cell
        end
      end)

    atom_headers =
      Enum.map(headers, fn header ->
        String.to_atom(header)
      end)

    Enum.map(values, fn value ->
      Enum.zip(atom_headers, value)
    end)
  end

  defp exec_cell(target, func) do
    [head | _] = target

    if is_list(head) do
      Enum.map(target, fn e ->
        exec_cell(e, func)
      end)
    else
      Enum.map(target, fn e ->
        func.(e)
      end)
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [sigil_v: 2]
      import unquote(__MODULE__), only: [sigil_v: 2]
    end
  end
end
