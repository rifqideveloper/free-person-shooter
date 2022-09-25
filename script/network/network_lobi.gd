extends HBoxContainer

func _on_tambah_pressed():
	if $"../..".get_child_count() != 2 :
		$"../..".add_child(load("res://scene/network/buat_server baru.tscn").instance())

func _on_sambung_pressed():
	pass # Replace with function body.
