extends Spatial

#var loading = preload("res://scene/looding.tscn")
var player = preload("res://scene/KinematicBody.tscn")
var player_data

func _ready():
	var v : File = File.new()
	if v.open("user://akun.dat",File.READ_WRITE) == OK :
		var x = v.get_var()
		
		if x != null :
			_login(x["nama"],x["pass"],x["tipe"])
	v.close()
	
func _latihan_selesai() -> void:
	var v : Node = get_child(get_child_count()-1)
	remove_child(v)
	v.queue_free()
	#v = ResourceLoader.load_interactive()
	v = load("res://scene/menu.tscn").instance()
	v.connect("latihan",self,"_on_menu_latihan")
	v.main = true
	add_child(v)
	$Camera.show()

func _on_menu_latihan():
	$Camera.hide()
	var v : Node = $menu
	remove_child(v)
	v.queue_free()
	#v = $Camera
	#remove_child(v)
	#v.queue_free()
	#v = ResourceLoader.load_interactive("res://scene/KinematicBody.tscn")
	v = player.instance()
	v.connect("keluar",self,"_latihan_selesai")
	add_child(v)

func _login(nama:String,pass_:String,tipe:int) -> void:
	$menu.ganti_akun({
		"nama":nama,
		"tipe":tipe,
		"pass":pass_
	})
	$menu.show()
	var v : Node = $buat_login
	remove_child(v)
	v.queue_free()
	var f : File = File.new()
	if f.open("user://akun.dat",File.WRITE) == OK :
		f.store_var({
			"nama":nama,
			"tipe":tipe,
			"pass":pass_
		})
	f.close()
#static func test() ->void:
#	EditorPlugin.add_autoload_singleton("Global","res://autoload/global.gd")
func _on_local_Button_pressed():
	var nama  : String = $buat_login/lokal/VBoxContainer/LineEdit.text.trim_suffix(" ")
	if !nama.empty() :
		_login(nama,"",get_node("/root/Global").tipe_akun.local)
