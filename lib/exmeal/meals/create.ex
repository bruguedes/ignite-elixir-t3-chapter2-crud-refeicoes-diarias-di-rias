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
end
