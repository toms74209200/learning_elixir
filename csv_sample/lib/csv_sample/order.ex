defmodule CsvSample.Order do
  @moduledoc """
  注文データに関する構造体の作成と分析を行うモジュールです。
  """

  defstruct [
    :gender,
    :age,
    :oil_level,
    :hard_level,
    :salt_level,
    :topping,
    :rice,
    :review
  ]

  @key_name_map %{
    gender: "性別",
    age: "年齢層",
    oil_level: "脂",
    hard_level: "硬さ",
    salt_level: "濃さ",
    topping: "トッピング",
    rice: "ライス",
    review: "評価"
  }

  def new(%{
        "性別" => gender,
        "年齢層" => age,
        "脂" => oil_level,
        "濃さ" => salt_level,
        "硬さ" => hard_level,
        "トッピング" => topping,
        "ライス" => rice,
        "評価" => review
      }) do
    %__MODULE__{
      topping: topping,
      rice: rice,
      age: age,
      gender: gender,
      oil_level: oil_level,
      salt_level: salt_level,
      hard_level: hard_level,
      review: review |> String.to_integer()
    }
  end

  def new(_), do: {:error, :required_key_dose_not_exist}

  @doc """
  注文構造体のキー名を日本語名称に変換します。
  """
  def en_key_to_ja(key), do: @key_name_map[key]

  @doc """
  注文構造体のリスト, 任意の性別と年齢層をもとにレビューの平均値を算出します。

  ## Examples
    iex> [
    ...>   %CsvSample.Order{
    ...>     age: "20代", gender: "男性", review: 2},
    ...>   %CsvSample.Order{
    ...>     age: "20代", gender: "男性", review: 5},
    ...>   %CsvSample.Order{
    ...>     age: "30代", gender: "男性", review: 5}
    ...> ]
    ...> |> CsvSample.Order.calc_review_avg("男性", "20代")
    3.5

  ※ サンプルの注文構造体は一部フィールドを割愛しています。
  """
  def calc_review_ave(orders, gender, age) do
    orders
    |> Enum.filter(fn order ->
      order.age == age && order.gender == gender
    end)
    |> Enum.map(& &1.review)
    |> then(fn reviews ->
      Enum.sum(reviews) / Enum.count(reviews)
    end)
  end

  def calc_order_rates(orders, filter_func) do
    orders
    |> Enum.filter(&filter_func.(&1))
    |> then(fn targets ->
      %{
        rice: calc_rate(targets, :rice),
        topping: calc_rate(targets, :topping),
        oil_level: calc_rate(targets, :oil_level),
        hard_level: calc_rate(targets, :hard_level),
        salt_level: calc_rate(targets, :salt_level)
      }
    end)
  end

  def calc_rate(orders, order_key) do
    total_count = Enum.count(orders)

    orders
    |> Enum.map(&Map.get(&1, order_key))
    |> Enum.group_by(& &1)
    |> Enum.map(fn {key, each_values} ->
      count = Enum.count(each_values)

      {
        key,
        count / total_count * 100
      }
    end)
    |> Map.new()
  end
end
