defmodule CsvSampleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest CsvSample

  describe "puts_review_avgs/1" do
    test "正常系" do

    end
  end

  describe "puts_review_map/2" do
    setup :setup_orders
    test "正常系", %{orders: orders} do
      log = capture_io(fn ->
        assert :ok = CsvSample.puts_review_avgs(orders)
      end)
      assert log =~ "10代以下男性：平均"
      assert log =~ "30代男性：平均"
      assert log =~ "50代男性：平均"
      assert log =~ "10代以下女性：平均"
      assert log =~ "30代女性：平均"
      assert log =~ "50代女性：平均"
    end
  end

  defp setup_orders(_) do
    [orders: CsvSample.import!("priv/ie_ramen.csv")]
  end
end
