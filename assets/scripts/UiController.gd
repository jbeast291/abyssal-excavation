extends CanvasLayer

@onready var status_label: Label = $StatusLabel
var initial_status_text: String;

func _ready() -> void:
	initial_status_text = status_label.text
	pass

func _physics_process(delta: float) -> void:
	status_label.text = get_status_text();
	pass

func get_status_text() -> String:
	var return_string: String = "";
	return_string = initial_status_text.replace("%oil%", String.num(GameManager.main.oil_value, 0));
	return_string = return_string.replace("%time%", String.num(GameManager.main.time_left_seconds, 1));
	return return_string;
