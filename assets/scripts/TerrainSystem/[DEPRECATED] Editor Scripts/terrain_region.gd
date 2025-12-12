@tool
extends Node2D
class_name TerrainRegion

@onready var selector_2: Node2D = $Selector2

@export var grid_snap_size: int = 8;
@export var color: Color = Color.RED:
	set(new_color):
		color = new_color
		queue_redraw();
@export var left: float;
@export var top: float;
@export var width: float;
@export var height: float;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	set_notify_transform(true);
	queue_redraw()
	pass

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAW:
		draw_box();
	elif what == NOTIFICATION_TRANSFORM_CHANGED:
		var snapped_pos = Vector2(
			round(position.x / grid_snap_size) * grid_snap_size,
			round(position.y / grid_snap_size) * grid_snap_size
		)
		if snapped_pos != position:
			position = snapped_pos;

func _on_node_2d_positon_updated() -> void:
	queue_redraw()
	pass # Replace with function body.

func draw_box() -> void:
	#print("move")
	var start = Vector2.ZERO; # since drawing is relative to this node's position
	var end = to_local(selector_2.global_position);

	left = min(start.x, end.x);
	top = min(start.y, end.y);
	width = abs(start.x - end.x);
	height = abs(start.y - end.y);

	draw_rect(Rect2(left, top, width, height), color, true)
	pass
