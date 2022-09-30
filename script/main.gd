extends Control
const loading = preload("res://autoload/global.gd").looding
export (loading) var tipe : int = loading.main
const beranda : PackedScene = preload("res://scene/beranda.tscn")

func _ready() -> void :
	OS.set_window_title("Free Person Shooter")
	#bug : login gagal dipeluncur di code art studio
	#fix 
	if get_node("/root/Global") == null :
		var script:Script = load("res://autoload/global.gd")
		print("test")
		var node : Node = Node.new()
		node.name = "Global"
		node.set_script(script)
		get_tree().root.add_child(node)
	#fix
	
func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_accept") or !$VideoPlayer.is_playing() :
		$VideoPlayer.emit_signal("finished")
	
func _on_VideoPlayer_finished() -> void:
	get_tree().change_scene_to(beranda)
	
