defmodule Exmeal.Meals.GetTest do
  use Exmeal.DataCase

  import Exmeal.Factory
  alias Exmeal.Meals.Schema.Meal

  describe "Get Meal" do
    test "when a valid id is given, returns the meal" do
      {:ok, %Meal{id: id}} = Exmeal.create_meal(build(:meal_params))
      response = Exmeal.get_meal_by_id(id)

      assert {:ok,
              %Exmeal.Meals.Schema.Meal{
                calories: 350,
                date: ~U[2021-07-30 12:00:00Z],
                description: "Frango com arroz integral",
                id: _id
              }} = response
    end

    test "when an invalid id is given, returns an error" do
      id = "a6ef9b39-d638-4835-9ad7-dbe48d1257eb"
      response = Exmeal.get_meal_by_id(id)

      assert {:error, %Exmeal.Error{error: "Meal not found", status: :not_found}} = response
    end
  end
end
