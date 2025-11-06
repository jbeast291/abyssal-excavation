@tool
extends Node2D
class_name TerrainRegion

@onready var selector_2: Node2D = $Selector2

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
	queue_redraw()
	pass

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAW:
		draw_box();

func _on_node_2d_positon_updated() -> void:
	queue_redraw()
	pass # Replace with function body.

func draw_box() -> void:
	#print("move")
	var start = Vector2.ZERO  # since drawing is relative to this node's position
	var end = to_local(selector_2.global_position)

	left = min(start.x, end.x)
	top = min(start.y, end.y)
	width = abs(start.x - end.x)
	height = abs(start.y - end.y)
	
	#print(str(left) + " " + str(top) + " " + str(width) + " " + str(height))

	draw_rect(Rect2(left, top, width, height), color, true)
	pass
	
