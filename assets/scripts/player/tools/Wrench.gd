class_name Wrench extends Tool

@onready var wrench_ray_cast: RayCast2D = $WrenchRayCast
@onready var rotate_to_mouse: RotateToMouse = $RotateToMouse

func _ready() -> void:
	pass # Replace with function body.

func deactivate() -> void:
	wrench_ray_cast.enabled = false;
	pass

func activate() -> void:
	wrench_ray_cast.enabled = true;
	pass

func physics_update(delta: float) -> void:
	rotate_to_mouse.physics_update(delta);
	pass
