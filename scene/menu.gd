extends CanvasLayer
signal mobile_activ
signal latihan 
signal keluar_dari_arena
signal lanjut

export var main : bool = true

var akun : Dictionary

func _ready() -> void:
	
	$Control/CenterContainer/VBoxContainer/pengaturan.connect("pressed",self,"_on_pengaturan_pressed")
	
	if !main :
		var multiplayer : Node = $Control/CenterContainer/VBoxContainer/multiplayer
		var latihan : Node = $Control/CenterContainer/VBoxContainer/latihan
		var map : Node = $"Control/CenterContainer/VBoxContainer/map editor"
		
		$Control/CenterContainer/VBoxContainer.remove_child(multiplayer)
		$Control/CenterContainer/VBoxContainer.remove_child(latihan)
		$Control/CenterContainer/VBoxContainer.remove_child(map)
		
		multiplayer.queue_free()
		latihan.queue_free()
		map.queue_free()
		$Control/CenterContainer/VBoxContainer/lanjut.connect("pressed",self,"_on_lanjut_pressed")
		$Control/CenterContainer/VBoxContainer/keluar.connect("pressed",self,"_on_keluar_pressed")
		return
	elif OS.has_feature("web") and load("res://codeart/scene/main.tscn") == null:
		var v : Node = $Control/CenterContainer/VBoxContainer/keluar
		$Control/CenterContainer/VBoxContainer.remove_child(v)
		v.queue_free()
		
	$Control/CenterContainer/VBoxContainer/multiplayer.connect("pressed",self,"_on_multiplayer_pressed")
	$Control/CenterContainer/VBoxContainer/latihan.connect("pressed",self,"_on_latihan_pressed")
	$"Control/CenterContainer/VBoxContainer/map editor".connect("pressed",self,"_on_map_editor_pressed")
	$Control/CenterContainer/VBoxContainer/keluar.connect("pressed",self,"_keluar_game")
	
	var v = $Control/CenterContainer/VBoxContainer/lanjut
	$Control/CenterContainer/VBoxContainer.remove_child(v)
	v.queue_free()
		
		
func _on_keluar_pressed() -> void:
	get_tree().change_scene("res://scene/beranda.tscn")
	#emit_signal("keluar_dari_arena")
		
func _keluar_game() -> void:
	#code art studio integrasi
	#print(load("res://codeart/scene/main.tscn") != null) 
	if load("res://codeart/scene/main.tscn") != null:
		print("kepeluncur")
		get_tree().change_scene("res://codeart/scene/main.tscn")
	else:
		print("keluar game")
		get_tree().quit(0)
	

func ganti_akun(_akun_:Dictionary) -> void:
	akun = _akun_
	$"Control/akun pilihan"._ganti_aku(akun)



func _on_pengaturan_pressed() -> void:
	var v : Node = load("res://scene/pengaturan.tscn").instance()
	v.connect("mobile_activ",self,"_mobile_activ")
	v.connect("keluar",self,"_hapus_node_akhir")
	#v.connect("keluar",self,"_hapus_node_akhir")
	add_child(v)
	$Control/CenterContainer/VBoxContainer.visible = false

func _mobile_activ(tekan:bool) -> void:
	emit_signal("mobile_activ",tekan)

func _on_latihan_pressed() -> void:
	get_tree().change_scene("res://scene/latihan/latihan.tscn")
	#get_node("/root/Global").emit_signal("looding")
	#emit_signal("latihan")

func _on_multiplayer_pressed() -> void:
	$Control.visible = false
	var v : Node = load("res://scene/lobi.tscn").instance()
	v.connect("kembali",self,"_kembali_multiplayer_")
	add_child(v)
	

func _on_map_editor_pressed():
	get_tree().change_scene("res://scene/map/map editor.tscn")
	
func _kembali_multiplayer_() -> void:
	
	var v : Node = get_child(get_child_count() - 1)
	remove_child(v)
	v.queue_free()
	visible = true

func _hapus_node_akhir() -> void:
	var v : Node = get_child(get_child_count() - 1)
	remove_child(v)
	v.queue_free()
	$Control/CenterContainer/VBoxContainer.visible = true
	

func _on_lanjut_pressed():
	emit_signal("lanjut")

