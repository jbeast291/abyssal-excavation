extends Node2D

func on_start_new_game_button() -> void:
	self.get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	pass
