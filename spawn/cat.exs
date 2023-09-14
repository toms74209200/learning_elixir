defmodule GrepExecutor do
  def grep(scheduler) do
    send(scheduler, {:ready, self()})

    # 検索するディレクトリと検索する単語をメッセージとして受け取る
    receive do
      {:grep, {path, word}, client} ->
        send(client, {:answer, word, grep_exe(path, word), self()})
        grep(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end

  # 指定したディレクトリ"path"にあるファイルをそれぞれ読み込み, "word"という単語が何個含まれているか数える
  defp grep_exe(path, word) do
    File.ls!(path)
    |> Enum.reject(fn path -> File.dir?(path) end)
    |> Enum.map(fn file -> File.read!(path <> "/" <> file) end)
    |> Enum.map(fn file -> String.split(file, " ") end)
    |> Enum.map(fn file -> Enum.count(file, fn x -> x == word end) end)
    |> Enum.sum()
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    1..num_processes
    |> Enum.map(fn _ -> spawn_link(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | tail] = queue
        send(pid, {:grep, next, self()})
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

to_process = List.duplicate({"..", "cat"}, 20)

Enum.each(1..10, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run, [num_processes, GrepExecutor, :grep, to_process])

  if num_processes == 1 do
    IO.puts(inspect(result))
    IO.puts("\n #    time (s)")
  end

  :io.format("~2B     ~.2f~n", [num_processes, time / 1_000_000.0])
end)
