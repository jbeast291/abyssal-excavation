@tool
extends Node2D

@export var grid_snap_size: int = 8;

signal positon_updated

var isDraw: bool = false;

func _ready() -> void:
	set_notify_transform(true);
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		emit_signal("positon_updated")
		var snapped_pos = Vector2(
			round(position.x / grid_snap_size) * grid_snap_size,
			round(position.y / grid_snap_size) * grid_snap_size
		)
		if snapped_pos != position:
			position = snapped_pos;
