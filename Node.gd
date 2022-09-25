extends Control
const loading = preload("res://autoload/global.gd").looding
export (loading) var tipe : int = loading.main

func _ready() -> void :
	get_tree().change_scene("res://scene/beranda.tscn")
