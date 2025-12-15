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
	return_string = initial_status_text.replace("%oil%", "30");
	return_string = return_string.replace("%time%", String.humanize_size(GameManager.main.current_time));
	return return_string;
