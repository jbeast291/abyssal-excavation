class_name TerrainGenerator extends RefCounted

var main_tile_layer: TerrainManager;
var placement_layer: PlacementLayerInfo;
var fog_layer: FogManager;

var generation_seed: int = 1234; 

func _init(_main_tile_layer: TerrainManager, _placement_layer: PlacementLayerInfo, _fog_layer: FogManager):
	main_tile_layer = _main_tile_layer;
	placement_layer = _placement_layer;
	fog_layer = _fog_layer;
	assert(main_tile_layer!=null);
	assert(placement_layer!=null);
	assert(fog_layer!=null);

func _generate_terrain():
	var stone_coords: Array[Vector2i] = []
	var stone_no_gen_coords: Array[Vector2i] = []
	
	var placement_cells: Array[Vector2i] = placement_layer.get_used_cells();
	
	for cell in placement_cells:
		var cellAtlasCoords: Vector2i = placement_layer.get_cell_atlas_coords(cell)
		if cellAtlasCoords == placement_layer.stone_atlas_coords:
			stone_coords.append(cell);
		if cellAtlasCoords == placement_layer.no_gen_stone_atlas_coords:
			stone_no_gen_coords.append(cell);
		if cellAtlasCoords == placement_layer.air_atlas_coords:
			main_tile_layer._set_cell_air(cell, true);
	main_tile_layer.set_cells_terrain_connect(stone_coords + stone_no_gen_coords, 0, 0, false)
	_generate_fog(main_tile_layer.get_used_cells());
	_generate_caves(stone_coords, generation_seed);
	placement_layer.queue_free();

func _generate_caves(stone_coords: Array[Vector2i], noise_seed: int, threshold: float = 0.57, noise_scale: float = 0.05):
	var noise: FastNoiseLite = FastNoiseLite.new()
	noise.seed = noise_seed;
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = noise_scale
	
	for cell in stone_coords:
		var x = float(cell.x)
		var y = float(cell.y)
		var n = noise.get_noise_2d(x, y)
		n = (n + 1.0) / 2.0
		
		if n > threshold:
			main_tile_layer._set_cell_air(cell, false)

func _generate_fog(cells: Array[Vector2i]):
	var fog_source_atlas_id: int = 0;
	for cell in cells:
		var neighbors: Array[Vector2i] = main_tile_layer._get_neighbor_tiles_radius(cell, main_tile_layer.fog_view_penetration)
		
		var air_nearby = false;
		for neighbor in neighbors:
			air_nearby = main_tile_layer._tile_is_air(neighbor);
			if air_nearby:
				break;
		if !air_nearby:
			fog_layer.set_cell(cell, fog_source_atlas_id, Vector2i.ZERO)
