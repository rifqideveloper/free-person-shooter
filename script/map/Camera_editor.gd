extends Camera


func _ready():
	translation = Vector3(0,0,15)
	$"..".rotation_degrees.x = -15
	
func _input(event):
	if Input.is_action_pressed("ui_up"):
		translation.z -= 0.5
	elif Input.is_action_pressed("ui_down"):
		translation.z += 0.5
		
	if Input.is_action_pressed("ui_right"):
		$"..".rotation_degrees.y -= .5
	elif Input.is_action_pressed("ui_left"):
		$"..".rotation_degrees.y += .5
		
	if Input.is_action_pressed("ui_rotasi_kiri"):
		$"..".rotation_degrees.x -= .5
	elif Input.is_action_pressed("ui_rotasi_kanan"):
		$"..".rotation_degrees.x += .5
	
