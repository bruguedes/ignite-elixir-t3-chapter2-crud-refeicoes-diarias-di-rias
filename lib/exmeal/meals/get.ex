defmodule Exmeal.Meals.Get do
  alias Exmeal.{Error, Repo}
  alias Exmeal.Meals.Schema.Meal

  def by_id(id) do
    case Repo.get(Meal, id) do
      %Meal{} = meal -> {:ok, meal}
      nil -> {:error, Error.error_user_not_found()}
    end
  end
end
