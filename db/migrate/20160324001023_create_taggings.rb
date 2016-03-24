class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :shortened_url, index: true, foreign_key: true
      t.references :tag_topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
