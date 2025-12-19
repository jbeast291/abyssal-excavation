extends Area2D

func _ready() -> void:
	pass
func _on_body_entered(_body: Node2D) -> void:
	var center_cell: Vector2i = TerrainManager.main.local_to_map(self.global_position);
	var cells: Array[Vector2i] = TerrainManager.main._get_neighbor_tiles_radius(center_cell, 4);
	for cell in cells:
		TerrainManager.main.mine_cell(cell)
