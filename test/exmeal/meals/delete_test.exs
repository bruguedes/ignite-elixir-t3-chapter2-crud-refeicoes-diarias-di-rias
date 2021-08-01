defmodule Exmeal.Meals.DeleteTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal
  alias Exmeal.Meals.Schema.Meal

  describe "Delete Meal" do
    test "when a valid id is given, returns the meal" do
      {:ok, %Meal{id: id}} = Exmeal.create_meal(build(:meal_params))

      response = Exmeal.delete_meal(id)

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
      response = Exmeal.delete_meal(id)

      assert {:error, %Exmeal.Error{error: "Meal not found", status: :not_found}} = response
    end
  end
end
