defmodule ExmealWeb.MealsViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View

  import Exmeal.Factory

  alias ExmealWeb.MealsView

  test "render create.json" do
    params = build(:meal_params)
    {_ok, meal} = Exmeal.create_meal(params)

    response = render(MealsView, "create.json", meal: meal)

    assert %{
             meal: %Exmeal.Meals.Schema.Meal{
               calories: 350,
               date: ~U[2021-07-30 12:00:00Z],
               description: "Frango com arroz integral",
               id: _id
             },
             message: "Meal created!"
           } = response
  end

  test "render meal.json" do
    params = build(:meal_params)
    {_ok, meal} = Exmeal.create_meal(params)

    response = render(MealsView, "meal.json", meal: meal)

    assert %{
             meal: %Exmeal.Meals.Schema.Meal{
               calories: 350,
               date: ~U[2021-07-30 12:00:00Z],
               description: "Frango com arroz integral",
               id: _id
             }
           } = response
  end
end
