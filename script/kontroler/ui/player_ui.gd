extends CanvasLayer

func _ready():
	modile_mode(get_node("/root/Global").cek_data()["mobile_controler"])
	
func modile_mode(set:bool = false) -> void :
	if $".".get_child_count() == 3 :
		if set :
			var v : Node = load("res://scene/controler/mobile_controler_pergerakan.tscn").instance()
			v.scale = Vector2(2,2)
			v.position = Vector2(118,483)
			add_child(v)
			v = load("res://scene/controler/mobile_joystick.tscn").instance()
			v.scale = Vector2(2,2)
			v.position = Vector2(937,406)
			add_child(v)
			v = load("res://scene/controler/tembak_mobile.tscn").instance()
			v.scale = Vector2(5,5)
			v.position = Vector2(800,275)
			add_child(v)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif !set :
		var v : Node = get_child(5)
		remove_child(v)
		v.queue_free()
		v = get_child(4)
		remove_child(v)
		v.queue_free()
		v = get_child(3)
		remove_child(v)
		v.queue_free()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
