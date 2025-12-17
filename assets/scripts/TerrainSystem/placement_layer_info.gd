class_name PlacementLayerInfo
extends TileMapLayer

#area to define links between the placement layer and the actual terrain
@export var stone_atlas_coords: Vector2i;
@export var no_gen_stone_atlas_coords: Vector2i;
@export var bedrock_atlas_coords: Vector2i;
@export var air_atlas_coords: Vector2i;

func _ready():
	print(self.tile_set.tile_size);
