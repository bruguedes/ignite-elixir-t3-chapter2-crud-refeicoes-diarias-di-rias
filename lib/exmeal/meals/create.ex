defmodule Exmeal.Meals.Create do
  alias Exmeal.{Error, Repo}
  alias Exmeal.Meals.DateParse
  alias Exmeal.Meals.Schema.Meal

  def call(params) do
    params
    |> DateParse.parse()
    |> meal_insert()
  end

  defp meal_insert({:ok, params}) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> hendle_insert()
  end

  defp meal_insert({:error, %Error{}} = err), do: err

  defp hendle_insert({:ok, %Meal{}} = new_meal), do: new_meal

  defp hendle_insert({:error, description_error}) do
    {:error, Error.build(:bad_request, description_error)}
  end

  # def date_parse(%{"date" => date, "time" => time} = params) do
  #   with {:ok, date} <- Date.from_iso8601(date),
  #        {:ok, time} <- Time.from_iso8601(time) do
  #     DateTime.new!(date, time)
  #     |> put_new_date(params)
  #   else
  #     {:error, _} -> {:error, Error.error_date_or_time()}
  #   end
  # end

  # def date_parse(params), do: {:ok, params}

  # defp put_new_date(new_date, params) do
  #   params =
  #     params
  #     |> Map.put("date", new_date)
  #     |> Map.delete("time")

  #   {:ok, params}
  # end
end
