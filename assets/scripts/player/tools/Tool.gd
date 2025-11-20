@abstract
class_name Tool extends Node2D

var tool_manager: ToolManager;

func activate() -> void:
	pass

func deactivate() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

#For ui stuff later, ignore for now
func get_sprite_icon(_delta: float) -> void:
	pass

#INPUT EVENTS
func on_primary_interact_just_pressed() -> void:
	pass

func on_secondary_interact_just_pressed() -> void:
	pass;

func on_primary_interact_just_released() -> void:
	pass

func on_secondary_interact_just_released() -> void:
	pass;
