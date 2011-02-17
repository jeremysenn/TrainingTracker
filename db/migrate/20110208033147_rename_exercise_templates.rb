class RenameExerciseTemplates < ActiveRecord::Migration
  def self.up
    rename_table :exercise_templates, :exercises
  end

  def self.down
    rename_table :exercises, :exercise_templates
  end
end
