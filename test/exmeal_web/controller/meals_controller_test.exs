defmodule Exmeal.MealsControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  describe "create/2" do
    test "when all params are valid, creates a meal", %{conn: conn} do
      params = build(:meal_params)

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "meal" => %{
                 "calories" => 350,
                 "date" => "2021-07-30T12:00:00Z",
                 "description" => "Frango com arroz integral",
                 "id" => _id
               },
               "message" => "Meal created!"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{description: "Banana"}

      expected_response = %{
        "message" => %{"calories" => ["can't be blank"], "date" => ["can't be blank"]}
      }

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when id exist, delete the meal", %{conn: conn} do
      params = build(:meal_params)

      {:ok, meal} = Exmeal.create_meal(params)

      id = meal.id

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> response(:no_content)

      assert "" = response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "5e694bc0-78fc-4600-bcd0-0733b7540a6e"

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> json_response(:not_found)

      assert %{
               "message" => "Meal not found"
             } = response
    end
  end

  describe "update/2" do
    test "when id exist, update the meal", %{conn: conn} do
      {:ok, meal} =
        Exmeal.create_meal(%{
          "calories" => 350,
          "date" => "2021-07-30T12:00:00Z",
          "description" => "Frango com arroz integral"
        })

      params = %{
        "id" => meal.id,
        "calories" => 800,
        "date" => "2021-08-01T12:00:00Z",
        "description" => "Frango frito"
      }

      response =
        conn
        |> put(Routes.meals_path(conn, :update, meal.id), params)
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => 800,
                 "date" => "2021-08-01T12:00:00Z",
                 "description" => "Frango frito",
                 "id" => meal.id
               }
             } == response
    end

    test "when not exist id, return an error", %{conn: conn} do
      id = "5e694bc0-78fc-4600-bcd0-0733b7540a6e"

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "Meal not found"} = response
    end
  end

  describe "get/2" do
    test "when id exist, return the meal", %{conn: conn} do
      params = build(:meal_params)

      {:ok, meal} = Exmeal.create_meal(params)

      id = meal.id

      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => 350,
                 "date" => "2021-07-30T12:00:00Z",
                 "description" => "Frango com arroz integral",
                 "id" => ^id
               }
             } = response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "5e694bc0-78fc-4600-bcd0-0733b7540a6e"

      response =
        conn
        |> get(Routes.meals_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "Meal not found"} = response
    end
  end
end
