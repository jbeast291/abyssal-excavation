class_name PipeConnector extends Node2D

@onready var pipe_drag_collision_check: RayCast2D = %PipeDragCollisionCheck

func is_connector_colliding() -> bool:
	return !pipe_drag_collision_check.is_colliding()

func set_raycast_active_state(enable: bool) -> void:
	pipe_drag_collision_check.enabled = enable;
