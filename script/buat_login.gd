extends TabContainer


func _ready():
	pass

func _physics_process(delta)-> void:
	if Input.is_action_just_pressed("ui_accept") :
		$lokal/VBoxContainer/Button.emit_signal("pressed")
