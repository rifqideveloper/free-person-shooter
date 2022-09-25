extends VBoxContainer


func _ready():
	$akun.connect("pressed",self,"_buka_akun")
	$seting.connect("pressed",self,"_seting")
	$keluar.connect("pressed",self,"_keluar")

func _buka_akun() -> void :
	$seting.visible = !$seting.visible
	$keluar.visible = !$keluar.visible
	
func _keluar() -> void :
	pass
	
func _seting() -> void :
	pass

func _ganti_aku(akun:Dictionary) -> void:
	$akun.text = akun.nama
