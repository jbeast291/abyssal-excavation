class_name PipeNode extends Area2D

@export var is_root: bool = false;
@export var is_oil_well: bool = false;

const PIPE_CONNECTOR = preload("uid://cn2inlq5chyb5")
@onready var selector_sprite: AnimatedSprite2D = %SelectorSprite
@onready var pipe_state_manager: StateMachine = %PipeStateManager
@onready var placement: Node = %Placement
@onready var hover: Node = %Hover
@onready var idle: State = %Idle
@onready var active: Node = %Active

var previous_state: State;

var connected_pipes: Array[PipeNode] = [];
var pipe_active: bool = false;

var pipe_connector: PipeConnector;
var is_drag_pipe: bool = false;
var drag_point: Node2D;

func _ready() -> void:
	assert(!is_root || !is_oil_well);
	pipe_active = is_root;
	if(is_root):
		pipe_state_manager.change_state(active.name);
	elif(is_oil_well):
		pipe_state_manager.change_state(idle.name);
	else:
		pipe_state_manager.change_state(placement.name);

func _physics_process(delta: float) -> void:
	self.global_rotation = 0;
	pipe_state_manager.physics_update(delta);
	if(is_drag_pipe):
		handle_drag_point();

func attempt_place_pipe(pipe_manager: Node2D) -> bool:
	return placement.attempt_place(pipe_manager);

func hoverPipe() -> bool:
	previous_state = pipe_state_manager.current_state;
	pipe_state_manager.change_state(hover.name);
	selector_sprite.visible = true;
	return true;

func unhoverPipe() -> bool:
	if(pipe_active):
		pipe_state_manager.change_state(active.name);
	else:
		pipe_state_manager.change_state(idle.name);
	selector_sprite.visible = false;
	return true;

func handle_drag_point() -> void:
	var pipe_scale: float = self.position.distance_to(drag_point.global_position);
	pipe_connector.scale.x = pipe_scale;
	pipe_connector.look_at(drag_point.global_position);
	if(!is_drag_valid()):
		pipe_connector.modulate = Color(2.43, 0.0, 0.0);
	else:
		pipe_connector.modulate = Color.WHITE;

func start_pipe_connect(obj: Node2D) -> void:
	pipe_connector = PIPE_CONNECTOR.instantiate();
	self.add_child(pipe_connector);
	is_drag_pipe = true;
	pipe_connector.set_raycast_active_state(true);
	drag_point = obj;

func update_drap_point(obj: Node2D) -> void:
	drag_point = obj;

func finish_pipe_connect(other_pipe: PipeNode) -> void:
	is_drag_pipe = false;
	drag_point = other_pipe;
	pipe_connector.set_raycast_active_state(false);
	connected_pipes.append(other_pipe);
	other_pipe.connected_pipes.append(self);
	handle_drag_point();#one last time to make sure :fingers_crossed:
	pipe_connector = null;
	PipeManager.main.update_network();

func cancel_pipe_connect() -> void:
	is_drag_pipe = false;
	drag_point = self;
	pipe_connector.set_raycast_active_state(false);
	handle_drag_point();
	pipe_connector.queue_free();

func is_drag_valid() -> bool:
	return pipe_connector.is_connector_colliding();

func activate_pipe() -> void:
	pipe_active = true;
	pipe_state_manager.change_state(active.name);
