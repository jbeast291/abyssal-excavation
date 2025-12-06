class_name Wrench extends Tool

@export var place_distance: float = 30;

const PIPE_NODE = preload("uid://3e7qcikegg3y");
@onready var cell_selector: AnimatedSprite2D = %CellSelector;
@onready var rotate_to_mouse: RotateToMouse = $RotateToMouse;
@onready var placement_holder: Node2D = %PlacementHolder
@onready var held_pipe_node: PipeNode;
@onready var player: Player = $"../.."

var snapped_pipes: Array[Area2D];
var should_snap: bool = false;

var is_dragging: bool = false;
var dragged_pipe: PipeNode;

enum state {placement, hover, drag};
var active_state: state = state.placement;

var hovered_pipe: PipeNode

func _ready() -> void:
	create_pipe_node_on_tool();
	pass # Replace with function body.

func deactivate() -> void:
	if(is_dragging):
		dragged_pipe.cancel_pipe_connect();
		is_dragging = false;
	if(hovered_pipe != null):
		hovered_pipe.unhoverPipe();
		hovered_pipe = null;
	self.visible = false;

func activate() -> void:
	self.visible = true;

func physics_update(delta: float) -> void:
	rotate_to_mouse.physics_update(delta);
	placement_distance_handle();
	
	if(active_state == state.placement):
		if(snapped_pipes.size() > 1):
			active_state = state.hover;
			held_pipe_node.visible = false;
			physics_update(delta);
			return;
		
		if(is_dragging):
			dragged_pipe.update_drap_point(placement_holder);
	
	elif(active_state == state.hover):
		
		if(snapped_pipes.size() <= 1):
			active_state = state.placement;
			if(hovered_pipe != null):
				hovered_pipe.unhoverPipe();
			held_pipe_node.visible = true;
			physics_update(delta);
			return;
		
		handle_pipe_hover();

func placement_distance_handle() -> void:
	var mouse_distance: float = self.global_position.distance_to(get_global_mouse_position());
	mouse_distance = clamp(mouse_distance, 5.0, place_distance);
	placement_holder.position.x = mouse_distance;

func handle_pipe_hover() -> void:
	var previous_pipe: PipeNode = hovered_pipe;
	hovered_pipe = _get_closest_collided_snapped() as PipeNode;
	hovered_pipe.hoverPipe();
	if(previous_pipe != null and previous_pipe != hovered_pipe):
		previous_pipe.unhoverPipe();
	
	if(is_dragging):
		dragged_pipe.update_drap_point(hovered_pipe)

func on_primary_interact_just_pressed() -> void:
	if(is_dragging and !dragged_pipe.is_drag_valid()):
		return;
	if(active_state == state.placement):
		if (held_pipe_node.attempt_place_pipe(player.pipe_holder)):
			held_pipe_node = null;
			create_pipe_node_on_tool();
			if(is_dragging):
				is_dragging = false;
				dragged_pipe.finish_pipe_connect(held_pipe_node);

	elif(active_state == state.hover):
		if(is_dragging):
			is_dragging = false;
			dragged_pipe.finish_pipe_connect(hovered_pipe);
		else:
			hovered_pipe.start_pipe_connect(placement_holder);
			dragged_pipe = hovered_pipe;
			is_dragging = true;

func create_pipe_node_on_tool() -> void:
	assert(held_pipe_node == null);
	
	held_pipe_node = PIPE_NODE.instantiate();
	held_pipe_node.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF
	placement_holder.add_child(held_pipe_node);
	held_pipe_node.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_ON

func _on_snap_collider_area_entered(area: Area2D) -> void:
	snapped_pipes.append(area);
	should_snap = true;

func _on_snap_collider_area_exited(area: Area2D) -> void:
	snapped_pipes.remove_at(snapped_pipes.find(area));
	if(snapped_pipes.size() <= 0):
		should_snap = false;

func _get_closest_collided_snapped() -> Area2D:
	var closest: Area2D = null;
	for node in snapped_pipes:
		if node == held_pipe_node:
			continue;
		elif closest == null:
			closest = node;
		elif node.position.distance_to(placement_holder.position) > closest.position.distance_to(placement_holder.position):
			closest = node;
	return closest;
