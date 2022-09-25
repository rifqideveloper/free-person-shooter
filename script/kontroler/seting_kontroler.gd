extends Label

const jenis = preload("res://autoload/global.gd").jenis_tombol_kontroler

export (jenis) var tipe = jenis.maju

func _ready():
	$Button.connect("button_down",self,"_ubah")

func _ubah()->void:
	pass
	
