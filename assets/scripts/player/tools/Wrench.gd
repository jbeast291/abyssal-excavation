class_name Wrench extends Tool

@onready var rotate_to_mouse: RotateToMouse = $RotateToMouse

func _ready() -> void:
	pass # Replace with function body.

func deactivate() -> void:
	pass

func activate() -> void:
	pass

func physics_update(delta: float) -> void:
	rotate_to_mouse.physics_update(delta);
	pass
