extends Spatial


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$magazin.emit_signal("tembak")
