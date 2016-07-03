defmodule BankWeb.Account do
  use BankWeb.Web, :model

  schema "accounts" do
    field :type, :string
    field :name, :string
    field :currency, :string
    belongs_to :customer, BankWeb.Customer

    timestamps()
  end

  def build_asset(name) do
    changeset(%BankWeb.Account{}, Map.put(%{type: "asset", currency: "USD"}, :name, name))
  end

  def build_wallet(name) do
    changeset(%BankWeb.Account{}, Map.put(%{type: "liability", currency: "USD"}, :name, name))
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :name, :currency])
    |> validate_required([:type, :name, :currency])
    |> unique_constraint(:name)
    |> validate_inclusion(:type, ~w(asset liability))
  end
end
