extends OptionButton

var jumlah_max_player : Array = []
onready var map_gen = $"../../../../../CanvasLayer/map_generator"

func _ready() -> void :
	for i in map_gen.map_1:
		add_item(i[0])
	_on_mode_item_selected(0)
	emit_signal("item_selected",0)

func _on_mode_item_selected(index:int) -> void:
	var map = map_gen.map_1[index]
	$"../fps/cheat/total_player/map".clear()
	jumlah_max_player.clear()
	for i in map[2]:
		jumlah_max_player.push_back(i)
		$"../fps/cheat/total_player/map".add_item(str(i[0])+ "/"+ str(i[1]))

func _on_map_item_selected(index:int) -> void:
	print("test")
	map_gen.kode_map(index)

func _on_max_player_item_selected(index):
	pass # Replace with function body.

func _on_CheckBox_toggled(button_pressed:bool):
	get_node("/root/Global").cheat_dibolehkan = button_pressed

func _on_LineEdit_text_changed(new_text):
	
	pass # Replace with function body.
