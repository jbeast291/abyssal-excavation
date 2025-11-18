extends State

@export var player: CharacterBody2D;
@export var jump_strength: float = 200;

func _ready():
	assert(player != null)

func physics_update(_delta: float) -> void:
	apply_upwards_velocity();
	
func apply_upwards_velocity():
	player.velocity.y -= jump_strength;
