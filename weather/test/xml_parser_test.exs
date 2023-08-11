defmodule XmlParserTest do
  use ExUnit.Case

  test "parse xml" do
    xml = """
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
    <current_observation version="1.0"
         xmlns:xsd="http://www.w3.org/2001/XMLSchema"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
        <credit>NOAA's National Weather Service</credit>
        <credit_URL>https://weather.gov/</credit_URL>
        <image>
                <url>https://weather.gov/images/xml_logo.gif</url>
                <title>NOAA's National Weather Service</title>
                <link>https://www.weather.gov</link>
        </image>
        <suggested_pickup>15 minutes after the hour</suggested_pickup>
        <suggested_pickup_period>60</suggested_pickup_period>
        <location>Denton Enterprise Airport, TX</location>
        <station_id>KDTO</station_id>
        <latitude>33.20505</latitude>
        <longitude>-97.20061</longitude>
        <observation_time>Last Updated on Aug 10 2023, 11:53 pm CDT</observation_time>
        <observation_time_rfc822>Thu, 10 Aug 2023 23:53:00 -0500</observation_time_rfc822>
        <weather>Fair</weather>
        <temperature_string>96.0 F (35.6 C)</temperature_string>
        <temp_f>96.0</temp_f>
        <temp_c>35.6</temp_c>
        <relative_humidity>37</relative_humidity>
        <wind_string>South at 9.2 MPH (8 KT)</wind_string>
        <wind_dir>South</wind_dir>
        <wind_degrees>170</wind_degrees>
        <wind_mph>9.2</wind_mph>
        <wind_kt>8</wind_kt>
        <pressure_string>1007.2 mb</pressure_string>
        <pressure_mb>1007.2</pressure_mb>
        <pressure_in>29.78</pressure_in>
        <dewpoint_string>66.0 F (18.9 C)</dewpoint_string>
        <dewpoint_f>66.0</dewpoint_f>
        <dewpoint_c>18.9</dewpoint_c>
        <heat_index_string>99 F (37 C)</heat_index_string>
        <heat_index_f>99</heat_index_f>
        <heat_index_c>37</heat_index_c>
        <visibility_mi>10.00</visibility_mi>
        <icon_url_base>https://forecast.weather.gov/images/wtf/small/</icon_url_base>
        <two_day_history_url>https://www.weather.gov/data/obhistory/KDTO.html</two_day_history_url>
        <icon_url_name>nskc.png</icon_url_name>
        <ob_url>https://www.weather.gov/data/METAR/KDTO.1.txt</ob_url>
        <disclaimer_url>https://www.weather.gov/disclaimer.html</disclaimer_url>
        <copyright_url>https://www.weather.gov/disclaimer.html</copyright_url>
        <privacy_policy_url>https://www.weather.gov/notice.html</privacy_policy_url>
    </current_observation>
    """

    parsed = Weather.XmlParser.parse(xml, [:location])
    assert parsed[:location] == "Denton Enterprise Airport, TX"
  end
end
