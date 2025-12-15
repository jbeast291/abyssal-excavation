extends State

@onready var ambient_light: BackBufferCopy = %AmbientLight
@onready var main_sprite: AnimatedSprite2D = %MainSprite

@onready var pipe_node: PipeNode = $"../.."

const oil_well_active: Color = Color(0.752, 0.0, 2.96, 1.0);
const active_color: Color = Color(0.0, 1.0, 0.0, 1.0);

func enter() -> void:
	main_sprite.play("Active")
	if(pipe_node.is_oil_well):
		ambient_light.modulate = oil_well_active;
		main_sprite.modulate = Color(3.407, 0.0, 3.407, 1.0)
	else:
		ambient_light.modulate = active_color;
		main_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)

func exit() -> void:
	main_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
