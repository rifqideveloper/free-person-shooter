extends HBoxContainer

var daftar_server : Array = []
var scrol : float = 0.0

var posisi : PoolByteArray = [0,0,0,0,0]

func _ready():
	$VScrollBar.connect("value_changed",self,"scrol")
	
	$ping/Button.connect("atur_posisi",self,"_atur_posisi")
	$lokasi/Button.connect("atur_posisi",self,"_atur_posisi")
	$map/Button.connect("atur_posisi",self,"_atur_posisi")
	$nama/Button.connect("atur_posisi",self,"_atur_posisi")
	$player/Button.connect("atur_posisi",self,"_atur_posisi")
	
func _atur_posisi(index:int,v:int) -> void :
	posisi[index] = v
	print_debug("atur_posisi ",posisi)

func scrol(v:float) -> void:
	if scrol < v :
		pass
	else :
		pass
	scrol = v
