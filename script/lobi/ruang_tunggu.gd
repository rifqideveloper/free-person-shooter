extends Spatial

const tipe_ruang =  preload("res://autoload/global.gd").tipe_ruang
onready var tipe : int = get_node("/root/Global").tipe_lobi
var ukuran_map : Array = [10,10]

var player_list : Array = [
	
]

func _ready():
	var f : File = File.new()
	var nama = preload("res://autoload/global.gd").nama_file_akun
	if f.open(nama,File.READ) == OK:
		var v = f.get_var()
		player_list.push_back([v["nama"],get_node("/root/Global").tipe_lobi,0,false])
	f.close()
	_ubah_tipe_ruang()
	$CanvasLayer/Panel/HFlowContainer/LineEdit_seed.connect("text_entered",self,"_seed")
	$CanvasLayer/Panel/HFlowContainer/acak_seed.connect("pressed",self,"_acak_seed")
	$CanvasLayer/Panel/HFlowContainer/LineEdit_ukuran_seed.connect("text_entered",self,"_ubah_ukuran")
	$CanvasLayer/Panel/HFlowContainer/acak_seed.emit_signal("pressed")
	$CanvasLayer/playerlist._update(player_list)
func _seed(_seed) -> void :
	_update(tipe,_seed)

func _ubah_ukuran (ukur:String) -> void :
	if false :
		pass
	elif ukur.is_valid_integer() :
		ukuran_map[0] = int(ukur)
		ukuran_map[1] = ukuran_map[0]
		_seed($CanvasLayer/Panel/HFlowContainer/LineEdit_seed.text)
		
func _acak_seed() -> void :
	$CanvasLayer/Panel/HFlowContainer/LineEdit_seed.text = $map_generator._buat_seed()
	
	_update(tipe,$CanvasLayer/Panel/HFlowContainer/LineEdit_seed.text)

func _update(tipe:int,_seed:String) -> void :
	if tipe == tipe_ruang.Master or  tipe == tipe_ruang.master_server :
		$map_generator.emit_signal("buat_map",_seed,ukuran_map[0],ukuran_map[1],false)
	else :
		pass

func _ubah_tipe_ruang() -> void :
	match tipe :
		tipe_ruang.Master , tipe_ruang.master_server:
			$CanvasLayer/Panel/HFlowContainer/Label_nama.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_nama.visible = true
			$CanvasLayer/Panel/HFlowContainer/Label_seed.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_seed.visible = true
			$CanvasLayer/Panel/HFlowContainer/Label_fps.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_fps.visible = true
			$CanvasLayer/Panel/HFlowContainer/Label_mode.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_mode.visible = true
			$CanvasLayer/Panel/HFlowContainer/Label_jumlah.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_jumlah.visible = true
		
		
		tipe_ruang.Server :
			$CanvasLayer/Panel/HFlowContainer/Label_nama.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_nama.visible = true
			$CanvasLayer/Panel/HFlowContainer/Label_seed.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_seed.visible = true
			$CanvasLayer/Panel/HFlowContainer/Label_fps.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_fps.visible = true
			$CanvasLayer/Panel/HFlowContainer/Label_mode.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_mode.visible = true
			$CanvasLayer/Panel/HFlowContainer/Label_jumlah.visible = false
			$CanvasLayer/Panel/HFlowContainer/LineEdit_jumlah.visible = true
		tipe_ruang.Pengunjung :
			$CanvasLayer/Panel/HFlowContainer/Label_nama.visible = true
			$CanvasLayer/Panel/HFlowContainer/LineEdit_nama.visible = false
			$CanvasLayer/Panel/HFlowContainer/Label_seed.visible = true
			$CanvasLayer/Panel/HFlowContainer/LineEdit_seed.visible = false
			$CanvasLayer/Panel/HFlowContainer/Label_fps.visible = true
			$CanvasLayer/Panel/HFlowContainer/LineEdit_fps.visible = false
			$CanvasLayer/Panel/HFlowContainer/Label_mode.visible = true
			$CanvasLayer/Panel/HFlowContainer/LineEdit_mode.visible = false
			$CanvasLayer/Panel/HFlowContainer/Label_jumlah.visible = true
			$CanvasLayer/Panel/HFlowContainer/LineEdit_jumlah.visible = false
	#_update(tipe,null)


func _on_Button_pressed():
	print("siap")
