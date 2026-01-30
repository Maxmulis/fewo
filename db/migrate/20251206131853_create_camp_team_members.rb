class CreateCampTeamMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :camp_team_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :camp, null: false, foreign_key: true

      t.timestamps
    end

    add_index :camp_team_members, [:user_id, :camp_id], unique: true
  end
end
