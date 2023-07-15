defmodule ConverterTest do
  use ExUnit.Case


  test "identify snake_case" do
    assert Converter.identify("tocard_qui_suce_des_ours", :snake) == ["tocard", "qui", "suce", "des", "ours"]
  end

  test "identify camelCase" do
    assert Converter.identify("tocardQuiSuceDesOurs", :camel) == ["tocard", "qui", "suce", "des", "ours"]
  end

  test "identify Pascalcase" do
    assert Converter.identify("TocardQuiSuceDesOurs", :pascal) == ["tocard", "qui", "suce", "des", "ours"]
  end

  test "identify kebab-case" do
    assert Converter.identify("tocard-qui-suce-des-ours", :kebab) == ["tocard", "qui", "suce", "des", "ours"]
  end




  test "convert to snake_case" do
    assert Converter.format(["test","conversion","to","snake"], :snake) == "test_conversion_to_snake"
  end

  test "convert to camelCase" do
    assert Converter.format(["test","conversion","to","camel"], :camel) == "testConversionToCamel"
  end

  test "convert to PascalCase" do
    assert Converter.format(["test","conversion","to","pascal"], :pascal) == "TestConversionToPascal"
  end

  test "convert to kebab-case" do
    assert Converter.format(["test","conversion","to","kebab"], :kebab) == "test-conversion-to-kebab"
  end
end
