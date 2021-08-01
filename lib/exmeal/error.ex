defmodule Exmeal.Error do
  @keys [:status, :error]
  @enforce_keys @keys

  defstruct @keys

  def build(status, descripition_error) do
    %__MODULE__{
      status: status,
      error: descripition_error
    }
  end

  def error_date_or_time, do: build(:bad_request, "Invalid date or time format")
  def error_user_not_found, do: build(:not_found, "Meal not found")
end
