extends Area2D

@export var apply_force_on_walking: bool = false;

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
