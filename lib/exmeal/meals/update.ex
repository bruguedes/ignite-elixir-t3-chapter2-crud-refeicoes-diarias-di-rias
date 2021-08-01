defmodule Exmeal.Meals.Update do
  alias Ecto.Changeset
  alias Exmeal.Meals.{DateParse, Get}
  alias Exmeal.Meals.Schema.Meal
  alias Exmeal.Repo

  def call(%{"id" => id} = params) do
    with {:ok, %Meal{} = meal} <- Get.by_id(id),
         {:ok, params} <- DateParse.parse(params),
         %Changeset{valid?: true} = changeset <- Meal.changeset(meal, params) do
      Repo.update(changeset)
    end
  end

  # defp do_update(user, params) do
  #   user
  #   |> Meal.changeset(params)
  #   |> Repo.update()
  # end
end
