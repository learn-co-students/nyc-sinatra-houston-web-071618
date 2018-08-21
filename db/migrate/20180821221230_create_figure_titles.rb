class CreateFigureTitles < ActiveRecord::Migration
  def change
    create_join_table :figures, :titles do |t|
      t.index :figure_id
      t.index :title_id
    end
  end
end
