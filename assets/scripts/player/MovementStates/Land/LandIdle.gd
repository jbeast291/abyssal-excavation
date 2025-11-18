extends State

@onready var body_sprite_manager: PlayerSpriteManager = %BodySpriteManager
@export var player: CharacterBody2D;

func _ready():
	assert(player != null)

func enter() -> void:
	body_sprite_manager.play_leg_animation("land_idle")
	body_sprite_manager.play_torso_animation("land_idle")

func physics_update(_delta: float) -> void:
	player.velocity.x = 0;
