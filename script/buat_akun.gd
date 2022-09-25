extends CanvasLayer

signal  kirim_data_akun (data)
var login : bool = false

var akun = get_node("/root/Global").akun

func _ready():
	var file : File = File.new()
	if file.file_exists("user://akun_offline.dat"):
		var error = file.open_encrypted_with_pass("user://akun_offline.dat",File.READ,"")
		if error == OK:
			akun = file.get_var()
			emit_signal("kirim_data_akun",akun)
		else:	
			login = true
			$Control/CenterContainer/VBoxContainer/pass.visible = true
			$"Control/CenterContainer/VBoxContainer/buat akun".text = login
	else:
		pass
	file.close()

func _on_CheckBox_pressed():
	var b : bool = $Control/CenterContainer/VBoxContainer/CheckBox.pressed
	$Control/CenterContainer/VBoxContainer/password.visible = b
	$Control/CenterContainer/VBoxContainer/pass.visible = b
	$Control/CenterContainer/VBoxContainer/pass2.visible = b


func _on_buat_pressed():
	if login :
		pass
	elif $Control/CenterContainer/VBoxContainer/CheckBox.pressed and $Control/CenterContainer/VBoxContainer/nama.text != "" and $Control/CenterContainer/VBoxContainer/pass.text != "" and $Control/CenterContainer/VBoxContainer/pass.text == $Control/CenterContainer/VBoxContainer/pass2.text:
		pass
	elif $Control/CenterContainer/VBoxContainer/nama.text != "":
		var file : File = File.new()
		akun.nama = $Control/CenterContainer/VBoxContainer/nama.text
		file.open_encrypted_with_pass("user://akun_offline.dat",File.WRITE,"")
		file.store_var(akun)
		file.close()
		emit_signal("kirim_data_akun",akun)
