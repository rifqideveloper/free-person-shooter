extends VBoxContainer


func _ready():
	$akun.connect("pressed",self,"_buka_akun")
	$seting.connect("pressed",self,"_seting")
	$keluar.connect("pressed",self,"_keluar")

func _buka_akun() -> void :
	$seting.visible = !$seting.visible
	$keluar.visible = !$keluar.visible
	
func _keluar() -> void :
	var nama_file_akun : String = preload("res://autoload/global.gd").nama_file_akun
	
	var f : File = File.new()
	if f.open(nama_file_akun,File.READ_WRITE) == OK :
		print("hapus ",f.get_sha256(nama_file_akun))
		f.store_var(null)		
		f.flush()
		print("hapus ",f.get_sha256(nama_file_akun))
	f.close()
	
	get_tree().change_scene("res://scene/beranda.tscn")
	
	
func _seting() -> void :
	pass

func _ganti_aku(akun:Dictionary) -> void:
	$akun.text = akun.nama
