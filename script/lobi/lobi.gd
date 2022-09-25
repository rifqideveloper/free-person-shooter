extends CanvasLayer
signal kembali

func _ready():
	$tabel/GridContainer/network/kembali.connect("pressed",self,"_kembali")

func _kembali() -> void :
	emit_signal("kembali")


