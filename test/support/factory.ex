defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Ecto.UUID
  alias Exmeal.Meals.Schema.Meal

  def meal_params_factory do
    %{
      "calories" => 350,
      "date" => "2021-07-30",
      "time" => "12:00:00",
      "description" => "Frango com arroz integral"
    }
  end

  def meal_factory do
    %Meal{
      id: UUID.generate(),
      calories: 350,
      date: ~U[2021-07-30 12:00:00Z],
      description: "Frango com arroz integral"
    }
  end
end
