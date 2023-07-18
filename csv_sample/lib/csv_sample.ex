defmodule CsvSample do
  alias CsvSample.Order

  def import!(path) do
    path
    |> Path.expand()
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.map(&Order.new(&1))
  end

  # 性別と年齢層のそれぞれのリストの組み合わせを作成し、レビューの平均値を取得して、標準出力に出力する
  def puts_review_avgs(orders) do
    ["男性", "女性"]
    |> Enum.each(fn gender ->
      ["10代以下", "20代", "30代", "40代", "50代", "60代以上"]
      |> Enum.each(fn age ->
        rate =
          orders
          |> Order.calc_review_ave(gender, age)
          |> Float.round(2)

        IO.puts("#{age}#{gender}：平均#{rate}点")
      end)
    end)
  end

  def puts_order_rates(orders) do
    ["男性", "女性"]
  |> Enum.each(fn gender ->
    ["10代以下", "20代", "30代", "40代", "50代", "60代以上"]
    |> Enum.each(fn age ->
      rate_map = orders |> Order.calc_order_rates(&(&1.gender == gender && &1.age == age))

      """
      #{age}#{gender}:
        #{rate_map|> format_rate_map(:rice) |> inspect()}
        #{rate_map|> format_rate_map(:topping) |> inspect()}
        #{rate_map|> format_rate_map(:oil_level) |> inspect()}
        #{rate_map|> format_rate_map(:hard_level) |> inspect()}
        #{rate_map|> format_rate_map(:salt_level) |> inspect()}
      """
      |> IO.puts()
    end)
  end)
  end

  defp format_rate_map(rate_map, key) do
    rate_map[key]
    |> Enum.map(fn {key, value} ->
      "#{key}: #{Float.round(value, 2)}%"
    end)
    |> then(fn rates ->
      %{"#{Order.en_key_to_ja(key)}": rates}
    end)
  end
end
