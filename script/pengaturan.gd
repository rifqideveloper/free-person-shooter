extends CanvasLayer
signal keluar

onready var setingan : Dictionary = preload("res://autoload/global.gd").setingan

func _ready() -> void:
	get_node("/root/Global").cek_data(setingan)
	_terapkan_pengaturan()
	$Control/keluar.connect("pressed",self,"_keluar")
func _keluar() -> void:
	emit_signal("keluar")
		
func _terapkan_pengaturan()-> void:
	#print("setingan",setingan)
	$Control/TabContainer/suara._on_HSlider_value_changed_master(setingan["suara_master"])
	OS.set_window_size(setingan.get("resolusi"))
	OS.window_fullscreen = setingan["window_mode"] > 0
	OS.window_borderless = setingan["window_mode"] > 1
	$Control/TabContainer/grafik/VBoxContainer/window_mode/OptionButton.emit_signal("item_selected",setingan.get("window_mode")) 

func _exit_tree() -> void:
	var file : File = File.new()
	file.open("user://setingan.dat",File.WRITE)
	file.store_var(setingan)
	file.close()	
	
	
	
