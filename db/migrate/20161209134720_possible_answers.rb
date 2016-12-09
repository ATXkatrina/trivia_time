class PossibleAnswers < ActiveRecord::Migration
  def change
    create_table :possibleanswers do |t|
      t.integer :round_id
      t.string :poss_answer
    end
  end
end
