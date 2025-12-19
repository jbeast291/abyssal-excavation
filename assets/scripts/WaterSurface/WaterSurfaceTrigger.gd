extends Area2D

@onready var wave_geometry: Polygon2D = $WaveGeometry
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@export var apply_force_on_walking: bool = false;

func _ready() -> void:
	if(visible_on_screen_notifier_2d.is_on_screen()):
		_on_visible_on_screen_notifier_2d_screen_entered();
	else:
		_on_visible_on_screen_notifier_2d_screen_exited();

func _on_area_entered(area: Area2D) -> void:
	if(area is not PlayerTrigger):
		return;
	
	var player: Player = (area as PlayerTrigger).player;
	
	var direction = area.global_position - global_position;
	var angle = direction.angle() - rotation;
	angle = wrapf(angle, -PI, PI);
	
	if(angle < 0):
		#print("entered walking side");
		player.set_swimming();
	else:
		#print("entered swimming side");
		player.set_walking(apply_force_on_walking);


#correct state if they extited on the wrong side
func _on_area_exited(area: Area2D) -> void:
	if(area is not PlayerTrigger):
		return;
	
	var player: Player = (area as PlayerTrigger).player;
	
	var direction = area.global_position - global_position;
	var angle = direction.angle() - rotation;
	angle = wrapf(angle, -PI, PI);
	
	if(angle < 0):
		#print("exited walking side");
		if(player.get_motor_state().name == "Water"):
			player.set_walking(apply_force_on_walking);
	
	else:
		#print("exited swimming side");
		if(player.get_motor_state().name == "Land"):
			player.set_swimming();


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	wave_geometry.visible = true;

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	wave_geometry.visible = false;
