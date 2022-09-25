extends Node2D

func _ready() -> void:
	pass

func _on_belakang_pressed():
	Input.action_press("ui_down")
	

func _on_belakang_released():
	Input.action_release("ui_down")


func _on_kiri_pressed():
	Input.action_press("ui_left")


func _on_kiri_released():
	Input.action_release("ui_left")


func _on_kanan_pressed():
	Input.action_press("ui_right")


func _on_kanan_released():
	Input.action_release("ui_right")


func _on_depan_pressed():
	Input.action_press("ui_up")


func _on_depan_released():
	Input.action_release("ui_up")


func _on_putar_kiri_pressed():
	Input.action_press("ui_rotasi_kiri")


func _on_putar_kiri_released():
	Input.action_release("ui_rotasi_kiri")


func _on_bawah_pressed():
	Input.action_press("_ui_duduk")


func _on_bawah_released():
	Input.action_release("_ui_duduk")


func _on_putar_kanan_pressed():
	Input.action_press("ui_rotasi_kanan")


func _on_putar_kanan_released():
	Input.action_release("ui_rotasi_kanan")


func _on_atas_pressed():
	Input.action_press("ui_select")


func _on_atas_released():
	Input.action_release("ui_select")
