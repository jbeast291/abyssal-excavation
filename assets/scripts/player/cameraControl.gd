extends Camera2D

#@export var player: CharacterBody2D;
# Zoom Settings
@export var max_zoom: float = 4.5;
@export var min_zoom: float = 2.5;
@export var zoom_speed: float = 0.125;

#func _ready() -> void:
	#assert(player!=null);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#position = player.position;
	handle_zoom();

func handle_zoom():
	if Input.is_action_just_pressed("Zoom-Out") && self.zoom.x > min_zoom:
		self.zoom -= Vector2(zoom_speed, zoom_speed)
	if Input.is_action_just_pressed("Zoom-In") && self.zoom.y < max_zoom:
		self.zoom += Vector2(zoom_speed, zoom_speed)
		
