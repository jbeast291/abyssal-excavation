extends State

@onready var ambient_light: BackBufferCopy = %AmbientLight
@onready var main_sprite: AnimatedSprite2D = %MainSprite

var state_active: bool;
const speed: float = 3;

func enter() -> void:
	main_sprite.play("Idle")
	ambient_light.modulate = Color(1.334, 1.282, 0.0, 1.0)

func exit() -> void:
	state_active = false;
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var time: float = Time.get_ticks_msec()/1000.0;
	var intensity = cos(time * speed);
	intensity = 2 + intensity;

	ambient_light.modulate = Color(1.353 * intensity, 1.301 * intensity, 0.0, 1.0)
