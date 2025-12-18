class_name RotateToMouse extends Component

var last_joy_axis: Vector2;

func physics_update(_delta: float) -> void:
	var parent: Node = get_parent();
	if parent is Node2D:
		var parent_node = parent as Node2D;
		if(Input.get_connected_joypads().size() > 0):
			parent_node.rotation = _get_joystick_angle_around_point();
		else:
			parent_node.rotation = _get_mouse_angle_around_point();

func _get_mouse_angle_around_point() -> float:
	var mouse_pos = get_global_mouse_position();
	var direction = mouse_pos - self.global_position;
	var angle = direction.angle();
	return angle;

func _get_joystick_angle_around_point() -> float:
	var x_axis: float = Input.get_axis("Joypad Right Stick_Left", "Joypad Right Stick_Right",);
	var y_axis: float = Input.get_axis("Joypad Right Stick_Up", "Joypad Right Stick_Down");
	var joy_axis: Vector2 = Vector2(x_axis, -y_axis);
	
	#deadzone
	if(joy_axis.length() < 0.4):
		joy_axis = Vector2.ZERO;
	
	if(joy_axis == Vector2.ZERO):
		joy_axis = last_joy_axis;
	last_joy_axis = joy_axis
	return joy_axis.angle();
