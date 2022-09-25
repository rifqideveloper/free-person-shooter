extends Popup
var lobi : PackedScene = preload("res://scene/lobi/ruangan_lobi.tscn")
func _ready() -> void:
	$VBoxContainer/OptionButton.add_item("pribadi")
	$VBoxContainer/OptionButton.add_item("publik")
	$VBoxContainer/OptionButton.select(0)
	show()
	
func _on_Button_pressed():
	if  $VBoxContainer/OptionButton.selected == 0:
		print("pribadi")
	else:
		print("publik")
	#lobi.set_meta("tipe",0)
	get_node("/root/Global").tipe_lobi = 2
	get_tree().change_scene_to(lobi)


func _on_keluar_pressed():
	queue_free()
