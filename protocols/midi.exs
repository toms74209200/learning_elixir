defmodule Midi do
  defstruct(content: <<>>)

  defmodule Frame do
    defstruct(
      type: "xxx",
      length: 0,
      data: <<>>
    )
  end

  def to_binary(%Midi.Frame{type: type, length: length, data: data}) do
    <<
      type::binary-4,
      length::integer-32,
      data::binary
    >>
  end

  def from_file(name) do
    %Midi{content: File.read!(name)}
  end
end

defimpl Enumerable, for: Midi do
  def _reduce(_content, {:halt, acc}, _fun) do
    {:halted, acc}
  end

  def _reduce(content, {:suspend, acc}, fun) do
    {:suspend, acc, &_reduce(content, &1, fun)}
  end

  def _reduce(_content = "", {:cont, acc}, _fun) do
    {:done, acc}
  end

  def _reduce(
        <<
          type::binary-4,
          length::integer-32,
          data::binary-size(length),
          rest::binary
        >>,
        {:cont, acc},
        fun
      ) do
    frame = %Midi.Frame{type: type, length: length, data: data}
    _reduce(rest, fun.(frame, acc), fun)
  end

  def reduce(%Midi{content: content}, state, fun) do
    _reduce(content, state, fun)
  end
end
