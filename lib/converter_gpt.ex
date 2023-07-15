defmodule ConverterGpt do

  @moduledoc """
    Converter generated using AI GPT chat
  """

  def convert(string, target_case) do
    guessed_case = guess_case(string)
    case guessed_case do
      :camel when target_case == :kebab ->
        camel_to_kebab(string)
      :camel when target_case == :pascal ->
        camel_to_pascal(string)
      :camel when target_case == :snake ->
        camel_to_snake(string)
      :kebab when target_case == :camel ->
        kebab_to_camel(string)
      :kebab when target_case == :pascal ->
        kebab_to_pascal(string)
      :kebab when target_case == :snake ->
        kebab_to_snake(string)
      :pascal when target_case == :camel ->
        pascal_to_camel(string)
      :pascal when target_case == :kebab ->
        pascal_to_kebab(string)
      :pascal when target_case == :snake ->
        pascal_to_snake(string)
      :snake when target_case == :camel ->
        snake_to_camel(string)
      :snake when target_case == :kebab ->
        snake_to_kebab(string)
      :snake when target_case == :pascal ->
        snake_to_pascal(string)
      _ -> string
    end
  end

  defp guess_case(string) do
    cond do
      String.contains?(string, "-") -> :kebab
      String.contains?(string, "_") -> :snake
      String.match?(string, ~r/^[a-z]+[A-Z]/) -> :camel
      true -> :pascal
    end
  end

  # Conversion functions
  defp camel_to_kebab(string) do
    string
    |> String.replace(~r/([a-z\d])([A-Z])/u, "\\1-\\2")
    |> String.downcase()
  end

  defp camel_to_pascal(string) do
    string
    |> String.replace_prefix(Regex.compile(~r/^[a-z]/), &String.capitalize/1)
  end

  defp camel_to_snake(string) do
    string
    |> String.replace(~r/([a-z\d])([A-Z])/u, "\\1_\\2")
    |> String.downcase()
  end

  defp kebab_to_camel(string) do
    string
    |> String.replace(~r/-(\w)/, fn captures -> String.capitalize(Enum.at(captures, 1)) end)
  end

  defp kebab_to_pascal(string) do
    string
    |> kebab_to_camel()
    |> String.replace_prefix(Regex.compile(~r/^[a-z]/), &String.capitalize/1)
  end

  defp kebab_to_snake(string) do
    string |> String.replace("-", "_")
  end

  defp pascal_to_camel(string) do
    string |> String.replace_prefix(Regex.compile(~r/^[A-Z]/), &String.downcase/1)
  end

  defp pascal_to_kebab(string) do
    string
    |> pascal_to_camel()
    |> camel_to_kebab()
  end

  defp pascal_to_snake(string) do
    string
    |> pascal_to_camel()
    |> camel_to_snake()
  end

  defp snake_to_camel(string) do
    string
    |> String.replace_prefix(Regex.compile(~r/^[a-z]/), &String.capitalize/1)
    |> String.replace(~r/_(\w)/, fn captures -> String.capitalize(Enum.at(captures, 1)) end)
  end

  defp snake_to_kebab(string) do
    string |> String.replace("_", "-")
  end

  defp snake_to_pascal(string) do
    string
    |> snake_to_camel()
    |> camel_to_pascal()
  end
end
