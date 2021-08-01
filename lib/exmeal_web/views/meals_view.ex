defmodule ExmealWeb.MealsView do
  use ExmealWeb, :view

  alias Exmeal.Meals.Schema.Meal

  def render("create.json", %{meal: %Meal{} = meal}) do
    %{
      message: "Meal created!",
      meal: meal
    }
  end

  # def render("user.json", %{user: %User{} = user}), do: %{user: user}
end
