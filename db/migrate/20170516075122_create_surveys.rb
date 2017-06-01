class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name, default: "Encode, Decode survey"

      t.timestamps null: false
    end
  end
end
