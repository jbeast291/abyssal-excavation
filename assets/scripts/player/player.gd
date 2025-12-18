class_name Player extends CharacterBody2D;
@onready var movement_state_machine: StateMachine = %MovementStateMachine
@onready var tool_manager: ToolManager = %ToolManager
@onready var wrench: Wrench = %Wrench

@onready var land: LandStateMachine = $MovementStateMachine/Land
@onready var water: StateMachine = $MovementStateMachine/Water

@export var pipe_holder: Node2D;
@export var player_color: Color;
# Mining state

func _ready():
	assert(pipe_holder!=null);
	#body_sprite.material.set_shader_parameter("replacement_color", player_color)
	pass

func _process(delta: float):
	movement_state_machine.update(delta);

func _physics_process(delta: float):
	movement_state_machine.physics_update(delta);
	tool_manager.physics_update(delta);

	if Input.is_action_just_pressed("Slot1"):
		tool_manager.change_tool("Drill");
	
	if Input.is_action_just_pressed("Slot2"):
		tool_manager.change_tool("Wrench");
	
	if Input.is_action_just_pressed("PrimaryInteract"):
		tool_manager.on_primary_interact_just_pressed();
	
	if Input.is_action_just_released("PrimaryInteract"):
		tool_manager.on_primary_interact_just_released();
	
	if Input.is_action_just_pressed("SecondaryInteract"):
		tool_manager.on_secondary_interact_just_pressed();
	
	if Input.is_action_just_released("SecondaryInteract"):
		tool_manager.on_secondary_interact_just_released();

func get_motor_state() -> State:
	return movement_state_machine.current_state;

func set_swimming() -> void:
	movement_state_machine.change_state("Water");

func set_walking(apply_force_on_walking: bool) -> void:
	movement_state_machine.change_state("Land");
	if(apply_force_on_walking):
		land.apply_upwards_force(150);
