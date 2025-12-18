class_name LandStateMachine extends StateMachine

@onready var body_sprite_manager: PlayerSpriteManager = %BodySpriteManager

const anim_prefix: String = "land_";
enum direction {left, right}

@export var player: CharacterBody2D;
@export var land_gravity: float = 9;

var current_direction = direction.right;

#Only use this for assertions, NO LOGIC
func _ready() -> void:
	super._ready();
	assert(player != null)
	
func exit() -> void:
	super.exit()
	body_sprite_manager.flip_sprite_h(false);

func physics_update(_delta: float) -> void:
	handle_sub_state();
	apply_gravity();
	player.move_and_slide()
	handle_sprite_direction();
	super.physics_update(_delta);
	
func handle_sub_state() -> void:
	if player.is_on_floor() && Input.is_action_just_pressed("Jump"):
		super.change_state("Jump");
	elif Input.get_axis("Left", "Right") == 0:
		super.change_state("Idle");
	elif Input.is_action_pressed("Sprint"):
		super.change_state("Run");
	else:
		super.change_state("Walk");
		

func apply_gravity():
	player.velocity.y += land_gravity;

func apply_upwards_force(force: int):
	player.velocity.y -= force;

func handle_sprite_direction():
	var current_input_dir = Input.get_axis("Left", "Right");

	if current_input_dir > 0:
		current_direction = direction.right;
	elif current_input_dir < 0:
		current_direction = direction.left;

	if current_direction == direction.left:
		body_sprite_manager.flip_sprite_h(true);
	else:
		body_sprite_manager.flip_sprite_h(false);
