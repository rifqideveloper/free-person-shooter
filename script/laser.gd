tool
extends RayCast
signal jarak (jarak)

func _ready():
	_update()

func _update():
	force_raycast_update()
	if is_colliding() :
		var origin = global_transform.origin
		var collision_point = get_collision_point()
		var distance = origin.distance_to(collision_point)
		emit_signal("jarak",distance)
		$CSGCylinder.scale.y = distance 
		$CSGCylinder.translation.y = distance/2
			
