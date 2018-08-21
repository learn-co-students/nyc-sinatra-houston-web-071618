class CreateFigures < ActiveRecord::Migration
  def change
    create_table :figures do |figure|
      figure.string :name
    end
  end
end
