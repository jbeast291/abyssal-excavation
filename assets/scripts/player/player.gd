extends CharacterBody2D;
@onready var movement_state_machine: StateMachine = %MovementStateMachine
@onready var tool_manager: ToolManager = %ToolManager
@onready var wrench: Wrench = %Wrench


@export var pip_holder: Node2D;
@export var player_color: Color;
# Mining state

func _ready():
	#body_sprite.material.set_shader_parameter("replacement_color", player_color)
	pass

func _process(delta: float):
	movement_state_machine.update(delta);

func _physics_process(delta: float):
	#print(
	#	TerrainManager.main.get_cell_tile_data(
	#		TerrainManager.main.local_to_map(
	#			TerrainManager.main.to_local(position))));
	movement_state_machine.physics_update(delta);
	tool_manager.physics_update(delta);
	if Input.is_action_just_pressed("DEBUG_SwitchMotorMode"):
		enter_water();
		#print(movement_state_machine.get_current_state_path());
		
	if Input.is_action_just_pressed("Slot1"):
		tool_manager.change_tool("Drill");
		
			
	if Input.is_action_just_pressed("Slot2"):
		tool_manager.change_tool("Wrench");
	pass
	
	if Input.is_action_just_pressed("Jump"):
		wrench.place_pipe();

func enter_water():
	movement_state_machine.change_state("Water");
