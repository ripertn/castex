defmodule Converter do
  @all_case [:snake, :camel, :pascal, :kebab]

  def convert(str, from_case \\ :camel , to_case \\ :snake)
  def convert(str, from_case, to_case) when from_case in @all_case and to_case in @all_case, do: {:ok, str |> identify(from_case) |> format(to_case)}
  def convert(_str, _from_case, _to_case), do: {:ko, "wrong case"}

  def identify(str, from_case \\ :camel)
  def identify(str, from_case) when from_case in [:camel, :pascal],
    do: str
            |> String.codepoints()
            |> Enum.reduce([""], fn c, [h|t] -> Regex.match?(~r"\p{Lu}", c) && [String.downcase(c),h] ++ t || [h <> c] ++ t end)
            |> Enum.reject(& &1 in [nil, ""])
            |> Enum.reverse()
  def identify(str, :snake), do: String.split(str, "_")
  def identify(str, :kebab), do: String.split(str, "-")



  def format(str_l, case \\ :snake)
  def format(str_l, :snake), do: Enum.intersperse(str_l, "_") |> Enum.into("")
  def format([h|t] = _str_l, :camel), do: h <> (Enum.map(t, &String.capitalize/1) |> Enum.into(""))
  def format(str_l, :pascal), do: Enum.map(str_l, &String.capitalize/1) |> Enum.into("")
  def format(str_l, :kebab), do: Enum.intersperse(str_l, "-") |> Enum.into("")
end
