tool
extends StaticBody
signal tembak
export var peluru = preload("res://scene/pisika/logic_peluru.tscn")
export var akselerasi : float = 0.01
export var kecepatan : float = 0


func _ready():
	var v = peluru.instance()
	v.akselerasi = akselerasi
	$Spatial.add_child(v)
	connect("tembak",self,"_tembak")
		
func _tembak() -> void :
	$Spatial.get_child($Spatial.get_child_count() - 1)._maju()
	var v = peluru.instance()
	v.akselerasi = akselerasi
	$Spatial.add_child(v)
	
		
		
