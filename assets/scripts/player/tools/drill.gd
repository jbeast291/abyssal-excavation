class_name Drill extends Tool

@onready var selector_overlay: AnimatedSprite2D = %CellSelector
@onready var drill_ray_cast: RayCast2D = %MiningRayCast
@onready var drill_sprite: AnimatedSprite2D = %DrillSprite
@export var player: CharacterBody2D;

var main_tile_layer;
var drill_speed: float:
	get:
		return drill_speed;
	set(value):
		time_to_damage = 1/value

var time_to_damage: float;
var current_target_cell: Vector2i;
var target_percent_for_hit: float;
var has_target: bool;

func _ready() -> void:
	assert(player!=null);
	main_tile_layer = TerrainManager.main;
	drill_speed = 10000;
	assert(main_tile_layer!=null)

func deactivate() -> void:
	selector_overlay.visible = false;
	drill_sprite.visible = false;

func activate() -> void:
	selector_overlay.visible = true;
	drill_sprite.visible = true;

func physics_update(delta: float) -> void:
	_update_target();
	_handle_input(delta);
	_handle_drill_sprite();
	drill_sprite.visible = true;

func _update_target():
	drill_ray_cast.rotation = _get_mouse_angle_around_player();
	
	drill_ray_cast.force_raycast_update();
	
	if drill_ray_cast.is_colliding():
		
		var direction = (drill_ray_cast.target_position).normalized().rotated(drill_ray_cast.rotation)
		var step_distance = 2.0 # number of pixels to step extra past the raycast collision
		var stepped_pos = drill_ray_cast.get_collision_point() + direction * step_distance
		var new_target_cell: Vector2i = main_tile_layer.local_to_map(stepped_pos)
		var world_pos = main_tile_layer.map_to_local(new_target_cell)
		
		selector_overlay.global_position = world_pos;
		selector_overlay.visible = true
		has_target = true;
		
		#reset progess on moving off the target
		if current_target_cell != new_target_cell:
			selector_overlay.stop();
			target_percent_for_hit = 0;
		
		current_target_cell = new_target_cell;
	else:
		has_target = false;
		selector_overlay.visible = false
		target_percent_for_hit = 0;
		
func _handle_drill_sprite():
	drill_sprite.rotation = drill_ray_cast.rotation;
	if drill_ray_cast.rotation < -PI/2 || drill_ray_cast.rotation > PI/2 :
		drill_sprite.flip_v = true;
	else:
		drill_sprite.flip_v = false;

func _handle_input(delta: float):
	if !has_target:
		return;
	
	if Input.is_action_pressed("Mine"):
		selector_overlay.play("drill")
		selector_overlay.speed_scale = 1/time_to_damage;
		
		if target_percent_for_hit > time_to_damage:
			target_percent_for_hit = 0
			main_tile_layer.mine_cell(current_target_cell);
			
		target_percent_for_hit += delta;
	else:
		selector_overlay.speed_scale = 1;
		selector_overlay.play("idle")

#in radians
func _get_mouse_angle_around_player() -> float:
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - player.global_position
	var angle = direction.angle()
	return angle
