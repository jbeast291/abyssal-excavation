extends State

@onready var pipe_node: PipeNode = $"../.."
@onready var main_collider: CollisionShape2D = %MainCollider
@onready var sprite_2d: Sprite2D = %Sprite2D

var colliding: bool;

var collision_count: int;

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if collision_count == 0: #|| pipe_node.placement_raycast.is_colliding() :
		sprite_2d.modulate = Color(1.0, 1.0, 1.0, 1.0);
	else:
		sprite_2d.modulate = Color(1.0, 0.0, 0.0, 1.0);
	

func _on_pipe_node_body_entered(_body: Node2D) -> void:
	collision_count += 1;

func _on_pipe_node_body_exited(_body: Node2D) -> void:
	collision_count -= 1;

func place(pipe_manager: Node2D) -> void:
	pipe_node.reparent(pipe_manager, true);
	state_machine.change_state("Idle");
