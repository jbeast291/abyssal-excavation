class_name ToolManager extends Node2D

@export var initial_tool: Tool;

var tools: Dictionary[String, Tool] = {};

var active_tool: Tool;

var primary_interact_down: bool = false;
var secondary_interact_down: bool = false;

func _ready() -> void:
	for child in get_children():
		if child is Tool:
			child.tool_manager = self;
			tools[child.name.to_lower()] = child;
			child.deactivate()
	active_tool = initial_tool;
	active_tool.activate()

func physics_update(delta: float) -> void:
	if active_tool != null:
		active_tool.physics_update(delta);

func change_tool(tool_name: String) -> void:
	var tool: Tool = tools.get(tool_name.to_lower());
	assert(tool, "State not found: " + tool_name);
	
	if active_tool != null:
		active_tool.deactivate();
	
	tool.activate();
	
	active_tool = tool;

func on_primary_interact_just_pressed() -> void:
	active_tool.on_primary_interact_just_pressed();
	primary_interact_down = true;

func on_primary_interact_just_released() -> void:
	active_tool.on_primary_interact_just_released();
	primary_interact_down = false;

func on_secondary_interact_just_released() -> void:
	active_tool.on_secondary_interact_just_pressed();
	secondary_interact_down = true;
	
func on_secondary_interact_just_pressed() -> void:
	active_tool.on_secondary_interact_just_released();
	secondary_interact_down = false;
