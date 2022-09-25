extends Control

func _ready():
	pass
#bug
func _on_hapus_akun_pressed():
	$konfirmasi.show()

func _on_konfirmasi_confirmed():
	var test =  Directory.new()
	if OK == test.remove("user://akun_offline.dat"):
		get_tree().change_scene("res://scene/beranda.tscn")
	else:
		OS.crash("")
	
