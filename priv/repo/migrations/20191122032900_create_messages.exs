defmodule CockroachLiveview.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :description, :string
      add :owner, :integer
    end
  end
end
