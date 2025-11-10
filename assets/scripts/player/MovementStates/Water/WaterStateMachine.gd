extends StateMachine

@onready var body_sprite_manager: PlayerSpriteManager = %BodySpriteManager
@export var sprite_rotation_speed: float = 5;

@onready var collider: CollisionShape2D = %Collider
@export var max_speed: float = 100
@export var drag: float = 100.0
@export var swim_gravity: float = 50
@export var player: CharacterBody2D;

var collider_original_height: int;
@export var collider_height: int = 12;

#Only use this for assertions, NO LOGIC
func _ready() -> void:
	super._ready();
	assert(player != null)
	
func enter() -> void:
	collider_original_height = collider.shape.height
	collider.shape.height = collider_height;
	super.enter();

func exit() -> void:
	super.exit();
	collider.shape.height = collider_original_height;

func physics_update(delta: float) -> void:
	sprite_rotation(delta);
	apply_gravity(delta);
	apply_drag(delta);
	limit_speed();
	player.move_and_slide()
	super.physics_update(delta);

func apply_gravity(delta: float):
	player.velocity.y += swim_gravity * delta;

func apply_drag(delta: float):
	player.velocity  = player.velocity.move_toward(Vector2.ZERO, drag * delta);

func limit_speed():
	if player.velocity.length() > max_speed:
		player.velocity = player.velocity.normalized() * max_speed;
		
func sprite_rotation(delta: float) -> void:
	var current_input_dir = Vector2(
		Input.get_axis("Left", "Right"),
		Input.get_axis("Up", "Down")
	)
	current_input_dir = current_input_dir.normalized();
	var desiredAngle = 0;

	if current_input_dir.length() != 0:
		desiredAngle = current_input_dir.angle() + PI/2;

	body_sprite_manager.rotation = lerp_angle(body_sprite_manager.rotation, desiredAngle, sprite_rotation_speed * delta);
