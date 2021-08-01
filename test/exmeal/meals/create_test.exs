defmodule Exmeal.Meals.CreateTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.Meals.Schema.Meal

  describe "Create Meal" do
    test "when all params are valid, returns the meal" do
      params = build(:meal_params)

      response = Exmeal.create_meal(params)

      assert {:ok,
              %Meal{
                calories: 350,
                date: ~U[2021-07-30 12:00:00Z],
                description: "Frango com arroz integral",
                id: _id
              }} = response
    end

    test "when there are invalid params, returns an error" do
      params =
        build(:meal_params)
        |> Map.put("calories", "aaa")

      response = Exmeal.create_meal(params)

      assert {:error, %Exmeal.Error{}} = response
    end
  end

  test "when hour is invalid, returns an error" do
    params =
      build(:meal_params)
      |> Map.put("time", "aa:aa")

    response = Exmeal.create_meal(params)

    assert {:error, %Exmeal.Error{}} = response
  end

  test "when hour is nil, returns an error" do
    params = %{
      calories: 350,
      description: "Frango com arroz integral"
    }

    response = Exmeal.create_meal(params)

    assert {:error, %Exmeal.Error{}} = response
  end

  test "when calories is nil, returns an error" do
    params = %{
      date: "2021-07-30",
      time: "12:00:00",
      description: "Frango com arroz integral"
    }

    response = Exmeal.create_meal(params)

    assert {:error, %Exmeal.Error{}} = response
  end
end
