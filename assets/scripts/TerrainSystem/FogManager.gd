class_name FogManager extends TileMapLayer

@export var terrainManager: TerrainManager;

var fog_source_id: int = 0;
var fog_atlas_coords: Vector2i = Vector2i(0,0);

func remove_fog_array(cells: Array[Vector2i]):
	for cell in cells:
		remove_fog_if_exists(cell);

func remove_fog_if_exists(cell: Vector2i):
	if get_cell_tile_data(cell) != null:
		erase_cell(cell)

func _debug_set_fog_transparent():
	var fog_tiles: Array[Vector2i] = get_used_cells_by_id(fog_source_id, fog_atlas_coords);
	if fog_tiles.size() < 1:
		push_error("No fog tiles found! Cannot make them transparent without at least one in the scene")
		return;
	var fog_tile_data: TileData = get_cell_tile_data(fog_tiles[0]);
	fog_tile_data.modulate = Color(1, 1, 1, 0.5);
	
