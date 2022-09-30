extends Panel
var nama_list : PackedScene = preload("res://scene/lobi/player_list_nama.tscn")
onready var kotiner = $VBoxContainer/ScrollContainer/VBoxContainer

func _update(player_list : Array) ->void :
	
	for i in range( kotiner.get_child_count() ) :
		var v : Node = kotiner.get_child(i)
		kotiner.remove_child(v)
		v.queue_free()
	
	for i in player_list :
		var v : Node = nama_list.instance()
		v.data = i
		kotiner.add_child(v)

