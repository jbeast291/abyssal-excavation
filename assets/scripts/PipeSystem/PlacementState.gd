extends State

@onready var pipe_node: PipeNode = $"../.."
@onready var main_collider: CollisionShape2D = %MainCollider

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
		print("Can Place")
	

func _on_pipe_node_body_entered(body: Node2D) -> void:
	collision_count += 1;

func _on_pipe_node_body_exited(body: Node2D) -> void:
	collision_count -= 1;
