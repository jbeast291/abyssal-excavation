class_name TerrainManager extends TileMapLayer;

@export var placement_layer: PlacementLayerInfo;
@export var fog_layer: FogManager;

@export var fog_view_penetration: int;
@export var debug_mode: bool = true;

var terrain_generator: TerrainGenerator;
var air_atlas_source_id = 1;
var air_unexplored_atlas_coords: Vector2i = Vector2i(0,0)
var air_explored_atlas_coords: Vector2i = Vector2i(1,0)
var cell_size: int = 8;
static var main: TerrainManager;

func _ready():
	assert(placement_layer!=null);
	assert(fog_layer!=null);
	main = self;
	
	terrain_generator = TerrainGenerator.new(self, placement_layer, fog_layer);
	terrain_generator._generate_terrain();
	terrain_generator = null; # godot will free the genertor from memory after this
	if debug_mode:
		activate_debug_mode();


func mine_cell(cell_pos: Vector2i):
	var cell_data = get_cell_tile_data(cell_pos);
	if cell_data == null:
		return;
		
	_set_cell_air(cell_pos, true);
	_reveal_connected_cave(cell_pos);


#NOTE: I have no clue if this even works still, but leaving it for now
func mine_cell_from_world_pos(cell_world_pos: Vector2):
	var cell_pos: Vector2i = self.local_to_map(self.to_local(cell_world_pos))
	if get_cell_tile_data(cell_pos) == null:
		return;
	mine_cell(cell_pos);


func _set_cell_air(cell: Vector2i, explored: bool):
	erase_cell(cell);#saftey so we remove any hanging custom data, may or may not be needed
	
	if explored:
		set_cell(cell, air_atlas_source_id, air_explored_atlas_coords, 0);
	else:
		set_cell(cell, air_atlas_source_id, air_unexplored_atlas_coords, 0);


func activate_debug_mode() -> void:
	fog_layer._debug_set_fog_transparent();
	_debug_set_air_visable();


## there is probably performance to be had here
## if we only clear fog on the edges of the cave it would reduce operations a lot
func _reveal_connected_cave(start_cell: Vector2i):
	var max_cave_reveal_size: int = 1000;# max ammount of cells to check if they are a part of the cave
	if !_tile_is_air(start_cell):
		return;
	
	var to_check: Array[Vector2i] = [start_cell];
	var visited: Dictionary = {};
	
	while to_check.size() > 0:
		var current: Vector2i = to_check.pop_back();
		if visited.has(current):
			continue;
		visited[current] = true;
		
		if !_tile_is_air(current):
			continue;
		
		fog_layer.remove_fog_if_exists(current)
		
		fog_layer.remove_fog_array(_get_neighbor_tiles_radius(current, fog_view_penetration));
		
		set_cell(current, 1, air_explored_atlas_coords);
		
		#dont add any more past this
		if visited.size() > max_cave_reveal_size:
			continue;
		
		for neighbor in _get_neighbor_tiles_radius(current, 1):
			if !visited.has(neighbor) and _tile_is_air(neighbor) and !_tile_explored(neighbor):
				to_check.append(neighbor)


func _tile_is_air(cell: Vector2i) -> bool:
	if get_cell_source_id(cell) == 1: # from air atlas
		return true;
	return false;


func _tile_explored(cell: Vector2i) -> bool:
	if get_cell_source_id(cell) == 1 and get_cell_atlas_coords(cell) == air_explored_atlas_coords:
		return true;
	if get_cell_tile_data(cell) == null:
		return false;
	return false;


func _get_neighbor_tiles_radius(cell: Vector2i, radius: int) -> Array[Vector2i]:
	var neighbor_cells: Array[Vector2i] = []
	for dx in range(-radius, radius + 1):
		for dy in range(-radius, radius + 1):
			if dx == 0 and dy == 0:# Skip center cell
				continue
			if Vector2(dx, dy).length() <= radius:
				neighbor_cells.append(cell + Vector2i(dx, dy))
	return neighbor_cells

func _debug_set_air_visable():
	var explored_air: Array[Vector2i] = get_used_cells_by_id(air_atlas_source_id, air_explored_atlas_coords);
	if explored_air.size() < 1:
		push_error("No explored air tiles found! Cannot make them visable without at least one in the scene")
		return;
	var explored_air_tile_data: TileData = get_cell_tile_data(explored_air[0]);
	explored_air_tile_data.modulate = Color(1, 1, 1, 1);

	var un_explored_air: Array[Vector2i] = get_used_cells_by_id(air_atlas_source_id, air_unexplored_atlas_coords);
	if un_explored_air.size() < 1:
		push_error("No explored air tiles found! Cannot make them visable without at least one in the scene")
		return;
	var un_explored_air_tile_data: TileData = get_cell_tile_data(un_explored_air[0]);
	un_explored_air_tile_data.modulate = Color(1, 1, 1, 1);
