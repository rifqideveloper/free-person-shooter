extends Button

export var node_modul : int 
onready var map_gen : Node = $"../../map_generator"

func _ready() -> void:
	connect("pressed",self,"_on_pressed")

func _on_pressed() -> void:
	print( map_gen.posisi_terpilih_sebelumnya._data() )
	map_gen._buat_modul(map_gen.posisi_terpilih_sebelumnya._data(),node_modul)
	#$"../..".code_map.push_back([node_modul])
	#$"../..".emit_signal("script_changed")
	#map_gen._modul_masuk(node_modul)
	if OS.has_feature("editor"):
		$"../../Label".text = str(map_gen.posisi_tersedia)
		$"../.."._debug()
		
