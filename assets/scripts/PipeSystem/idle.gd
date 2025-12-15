extends State

@onready var pipe_node: PipeNode = $"../.."
@onready var ambient_light: BackBufferCopy = %AmbientLight
@onready var main_sprite: AnimatedSprite2D = %MainSprite

var state_active: bool;
const speed: float = 3;

const oil_well_idle: Color = Color(0.752, 0.0, 2.96, 1.0);
const idle_color: Color = Color(1.334, 1.282, 0.0, 1.0);
var active_color: Color;

func enter() -> void:
	if(pipe_node.is_oil_well):
		active_color = oil_well_idle;
	else:
		active_color = idle_color;
	
	main_sprite.play("Idle");
	ambient_light.modulate = active_color;

func exit() -> void:
	state_active = false;
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var time: float = Time.get_ticks_msec()/1000.0;
	var intensity = cos(time * speed);
	intensity = 2 + intensity;

	ambient_light.modulate = Color(
		active_color.r * intensity,
		active_color.g * intensity,
		active_color.b * intensity,
		active_color.a)
