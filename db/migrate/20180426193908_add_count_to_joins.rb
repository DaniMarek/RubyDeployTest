class AddCountToJoins < ActiveRecord::Migration
  def change
    add_column :joins, :count, :integer
  end
end
