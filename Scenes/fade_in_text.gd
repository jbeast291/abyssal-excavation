extends Area2D

@export var label: Label;
@export var fade_physics_frames: int = 100;

var fading_in: bool;
var fading_out: bool;

func _ready() -> void:
	assert(label!=null);
	label.modulate.a = 0.0;

func _on_area_entered(area: Area2D) -> void:
	if area is not PlayerTrigger:
		return;
	fade_text_in();
	fading_in = true;
	fading_out = false;

func _on_area_exited(area: Area2D) -> void:
	if area is not PlayerTrigger:
		return;
	fade_text_out();
	fading_in = false;
	fading_out = true;

func fade_text_in() -> void:
	for i in range(fade_physics_frames):
		await get_tree().physics_frame;
		if(!fading_in):
			break;
		if(label.modulate.a >= 1.0):
			label.modulate.a = 1.0;
		label.modulate.a += 1.0/fade_physics_frames;

func fade_text_out() -> void:
	for i in range(fade_physics_frames):
		await get_tree().physics_frame;
		if(!fading_out):
			break;
		if(label.modulate.a <= 0.0):
			label.modulate.a = 0.0;
		label.modulate.a -= 1.0/fade_physics_frames;
