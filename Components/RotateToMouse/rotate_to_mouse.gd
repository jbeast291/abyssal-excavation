class_name RotateToMouse extends Component

func physics_update(_delta: float) -> void:
	var parent: Node = get_parent();
	if parent != null:
		(parent as Node2D).rotation = _get_mouse_angle_around_point();

func _get_mouse_angle_around_point() -> float:
	var mouse_pos = get_global_mouse_position();
	var direction = mouse_pos - self.global_position;
	var angle = direction.angle();
	return angle;
