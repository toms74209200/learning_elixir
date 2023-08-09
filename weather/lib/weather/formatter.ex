defmodule Weather.Formatter do
  require Weather.Formatter
  require Record
  Record.defrecord(:xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl"))
  Record.defrecord(:xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl"))
  @targets [:location, :station_id, :weather, :temp_c, :relative_humidity]
  @headers ['//location', '//station_id', '//weather', '//temp_c', '//relative_humidity']

  def print_data({data, _}) do
    elements =
      data
      |> get_child_elements()

    for tag <- @targets do
      elements
      |> find_child(tag)
      |> get_text()
      |> IO.puts()
    end
  end

  def get_child_elements(element) do
    Enum.filter(xmlElement(element, :content), fn child ->
      Record.is_record(child, :xmlElement)
    end)
  end

  def find_child(children, name) do
    Enum.find(children, fn child -> xmlElement(child, :name) == name end)
  end

  def get_text(element) do
    Enum.find(xmlElement(element, :content), fn child ->
      Record.is_record(child, :xmlText)
    end)
    |> xmlText(:value)
  end
end
