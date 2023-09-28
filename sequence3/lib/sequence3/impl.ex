defmodule Sequence.Impl do
  def next(number), do: number + 1
  def increment(number, delta), do: number + delta
  def push(stack, item), do: [item | stack]
  def pop([]), do: {:empty, []}
  def pop([head | tail]), do: {head, tail}
end
