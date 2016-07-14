class CreateTables < ActiveRecord::Migration
  def change
    
    create_table :users do |t|
      t.string :username, null: false
      t.string :avatar
      t.boolean :is_administrator, default: false
    end

    create_table :subjects do |t|
      t.string :name
    end

    create_table :critiques do |t|
      t.references :user
      t.references :subject
      t.boolean :is_ripe_banana, default: true
      t.string :content
      t.timestamps
    end

    create_table :votes do |t|
      t.references :user
      t.references :critique
    end

  end
end
