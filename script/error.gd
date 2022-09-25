extends CanvasLayer

export var pesan : String = "erro tidak diketahui"

var timer : int = 10
func _ready() -> void:
	$PopupDialog/Label.text = pesan
	Engine.set_target_fps(1)
	$PopupDialog.show()
	

func _on_Button_pressed() -> void:
	OS.crash(pesan)
	
func _on_PopupDialog_about_to_show():
	pass


func _on_PopupDialog_visibility_changed():
	pass

func _process(delta) -> void:
	print(timer)
	$PopupDialog/Button.text = "keluar ("+str(timer)+ ")"	
	if timer < 0 or Input.is_action_just_pressed("ui_accept"):
		OS.crash(pesan)
	timer -= 1
	
		
