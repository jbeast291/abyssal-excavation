extends Node2D

@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_mine_ray_collision(ray_left);
	check_mine_ray_collision(ray_right);

func check_mine_ray_collision(ray: RayCast2D):
	if ray.is_colliding():
		var direction = (ray.target_position).normalized().rotated(ray.rotation)
		var step_distance = 0.1 # number of pixels to step extra past the raycast collision
		var stepped_pos = ray.get_collision_point() + direction * step_distance
		var new_target_cell: Vector2i = TerrainManager.main.local_to_map(stepped_pos)
		TerrainManager.main.mine_cell(new_target_cell);
