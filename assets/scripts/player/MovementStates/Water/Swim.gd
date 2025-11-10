extends State

@onready var body_sprite_manager: PlayerSpriteManager = %BodySpriteManager
@export var player: CharacterBody2D;
@export var swim_acceleration: float = 500

func _ready():
	assert(player != null)
	
func enter() -> void:
	print("enter")
	body_sprite_manager.play_leg_animation("swim_swim");
	body_sprite_manager.play_torso_animation("swim_swim");
	body_sprite_manager.play_head_animation("up");

func physics_update(delta: float) -> void:
	apply_input(delta);

func apply_input(delta: float) -> void:
	var current_input_dir = Vector2(
		Input.get_axis("Left", "Right"),
		Input.get_axis("Up", "Down")
	)
	current_input_dir = current_input_dir.normalized();
	
	if current_input_dir != Vector2.ZERO:
		player.velocity += current_input_dir * swim_acceleration * delta;
