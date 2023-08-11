defmodule Weather.XmlParser do
  require Record
  Record.defrecord(:xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl"))
  Record.defrecord(:xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl"))

  def parse(xml, tags) do
    xml
    |> :binary.bin_to_list()
    |> :xmerl_scan.string()
    |> get_child_elements()
    |> parse_tag(tags)
  end

  defp get_child_elements({data, _}) do
    Enum.filter(xmlElement(data, :content), fn child ->
      Record.is_record(child, :xmlElement)
    end)
  end

  defp parse_tag(chiledren, tags) do
    Enum.map(tags, fn tag ->
      child =
        chiledren
        |> find_child(tag)
        |> get_text()
        |> to_string()

      {tag, child}
    end)
    |> Map.new()
  end

  defp find_child(children, name) do
    Enum.find(children, fn child -> xmlElement(child, :name) == name end)
  end

  defp get_text(element) do
    Enum.find(xmlElement(element, :content), fn child ->
      Record.is_record(child, :xmlText)
    end)
    |> xmlText(:value)
  end
end
