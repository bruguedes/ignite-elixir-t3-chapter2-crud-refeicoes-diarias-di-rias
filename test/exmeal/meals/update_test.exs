defmodule Exmeal.Meals.UpdateTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.Meals.Schema.Meal

  describe "Update Meal" do
    test "when a valid id is given, returns the meal" do
      {:ok, %Meal{id: id}} = Exmeal.create_meal(build(:meal_params))

      response = Exmeal.update_meal(%{"id" => id, "calories" => 25})

      assert {:ok,
              %Meal{
                calories: 25,
                date: ~U[2021-07-30 12:00:00Z],
                description: "Frango com arroz integral",
                id: ^id
              }} = response
    end

    test "when an invalid id is given, returns an error" do
      id = "a6ef9b39-d638-4835-9ad7-dbe48d1257eb"
      response = Exmeal.update_meal(%{"id" => id, "calories" => 25})

      assert {:error, %Exmeal.Error{error: "Meal not found", status: :not_found}} = response
    end
  end
end
