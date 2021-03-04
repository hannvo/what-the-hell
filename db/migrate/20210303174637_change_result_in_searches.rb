class ChangeResultInSearches < ActiveRecord::Migration[6.1]
  def change
    change_column_null :searches, :result_id, true
  end
end
