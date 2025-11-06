@tool
extends Node2D

signal positon_updated

var isDraw: bool = false;

func _ready() -> void:
	set_notify_transform(true);
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		emit_signal("positon_updated")
