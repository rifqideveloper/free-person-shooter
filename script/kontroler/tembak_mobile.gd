extends TouchScreenButton

func _ready():
	connect("pressed",self,"_tembak")
	connect("released",self,"_lepas")
	
func _tembak() -> void :
	Input.action_press("ui_tembak")
	$MeshInstance2D.modulate  = Color.red
	$MeshInstance2D2.modulate = Color.red
	$MeshInstance2D3.modulate = Color.red
	$MeshInstance2D4.modulate = Color.red
	$MeshInstance2D5.modulate = Color.red
	
func _lepas() -> void:
	Input.action_release("ui_tembak")
	$MeshInstance2D.modulate  = Color.white
	$MeshInstance2D2.modulate = Color.white
	$MeshInstance2D3.modulate = Color.white
	$MeshInstance2D4.modulate = Color.white
	$MeshInstance2D5.modulate = Color.white
