class CreateGamesTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :phone_id
      t.integer :no_questions
      t.integer :no_correct
      t.timestamps
    end
  end
end
