extends State

@onready var body_sprite_manager: PlayerSpriteManager = %BodySpriteManager
@export var player: CharacterBody2D;
@export var land_run_speed: float = 200;

func _ready():
	assert(player != null)
	
func enter() -> void:
	body_sprite_manager.play_leg_animation("land_run")
	body_sprite_manager.play_torso_animation("land_run")
	body_sprite_manager.play_head_animation("run")

func physics_update(_delta: float) -> void:
	apply_input();

func apply_input():
	var current_input_dir = Input.get_axis("Left", "Right");
	player.velocity.x = current_input_dir * land_run_speed;
