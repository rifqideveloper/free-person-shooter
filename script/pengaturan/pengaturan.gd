extends CanvasLayer
signal mobile_activ(tekan)
signal keluar
const window_mode = preload("res://autoload/global.gd").window_mode

func _ready():
	$keluar.connect("pressed",self,"_keluar")
	$Control/dasar/VBoxContainer/HBoxContainer/Label_bahasa.set_message_translation(true)
	$Control/dasar/VBoxContainer/HBoxContainer/bahasa.connect("item_selected",self,"_bahasa")
	$Control/dasar/VBoxContainer/HBoxContainer/bahasa.add_item("id")
	$Control/dasar/VBoxContainer/HBoxContainer/bahasa.add_item("en")	
	
	$Control/kontrol/VBoxContainer/mobile.pressed = get_node("/root/Global").cek_data()["mobile_controler"]
	
	$Control/grafik/VBoxContainer/window.add_item("full",window_mode.full)
	$Control/grafik/VBoxContainer/window.add_item("borderless",window_mode.borderless)
	$Control/grafik/VBoxContainer/window.add_item("window",window_mode.window)
	
	$Control/grafik/VBoxContainer/grafik.add_item("rendah")
	$Control/grafik/VBoxContainer/grafik.add_item("sedang")
	$Control/grafik/VBoxContainer/grafik.add_item("tinggi")
	$Control/grafik/VBoxContainer/grafik.add_item("asli")
	
	$Control/grafik/VBoxContainer/textur.add_item("rendah")
	$Control/grafik/VBoxContainer/textur.add_item("sedang")
	$Control/grafik/VBoxContainer/textur.add_item("tinggi")
	$Control/grafik/VBoxContainer/textur.add_item("asli")
	
	$Control/grafik/VBoxContainer/bayangan.add_item("rendah")
	$Control/grafik/VBoxContainer/bayangan.add_item("sedang")
	$Control/grafik/VBoxContainer/bayangan.add_item("tinggi")
	$Control/grafik/VBoxContainer/bayangan.add_item("asli")
	
	$"Control/grafik/VBoxContainer/qualitas mest".add_item("rendah")
	$"Control/grafik/VBoxContainer/qualitas mest".add_item("sedang")
	$"Control/grafik/VBoxContainer/qualitas mest".add_item("tinggi")
	$"Control/grafik/VBoxContainer/qualitas mest".add_item("asli")
	
	$Control/grafik/VBoxContainer/pencahayaan.add_item("rendah")
	$Control/grafik/VBoxContainer/pencahayaan.add_item("sedang")
	$Control/grafik/VBoxContainer/pencahayaan.add_item("tinggi")
	$Control/grafik/VBoxContainer/pencahayaan.add_item("asli")
	
	$Control/grafik/VBoxContainer/grafik.connect("item_selected",self,"_grafik")
	$Control/grafik/VBoxContainer/window.connect("item_selected",self,"_window")
	$Control/kontrol/VBoxContainer/mobile.connect("toggled",self,"_mobile_controler")
	var v = get_node("/root/Global").cek_data()
	_atur(v)
	#OS.set_window_size(_seting["resolusi"])
func _bahasa(index:int) -> void:
	match index:
		0 : 
			TranslationServer.set_locale("id")
			
		1 :
			TranslationServer.set_locale("en")
			
			
	$Control/dasar/VBoxContainer/HBoxContainer/bahasa.select(index)
	
func _keluar() -> void :
	emit_signal("keluar")
func _atur(pengaturan:Dictionary) -> void:
	$Control/grafik/VBoxContainer/window.emit_signal("item_selected",pengaturan.window_mode)  
	
func _window(index) -> void:
	OS.window_fullscreen = index == window_mode.full or index == window_mode.borderless
	OS.window_borderless = index == window_mode.borderless
	$Control/grafik/VBoxContainer/window.select(index)
	get_node("/root/Global")._ubah_pengaturan("window_mode",index)

func _mobile_controler(tekan:bool) -> void:
	emit_signal("mobile_activ",tekan)
	get_node("/root/Global")._ubah_pengaturan("mobile_controler",tekan)
	
func _grafik(index) -> void:
	var v : Dictionary
	get_node("/root/Global").emit_signal("ubah_grafik",v)
	
