defmodule Exmeal.MealTest do
  use Exmeal.DataCase

  alias Ecto.Changeset

  alias Exmeal.Meals.DateParse
  alias Exmeal.Meals.Schema.Meal

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        "description" => "Batata",
        "date" => "2001-05-02",
        "time" => "12:00:00",
        "calories" => "20"
      }

      {:ok, params} = DateParse.parse(params)
      response = Meal.changeset(params)

      assert %Changeset{
               changes: %{calories: 20, date: ~U[2001-05-02 12:00:00Z], description: "Batata"},
               valid?: true
             } = response
    end
  end
end
