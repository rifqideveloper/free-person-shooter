extends TouchScreenButton


func _ready():
	connect("pressed",self,"_tekan")
	connect("released",self,"_lepas")
	
func _tekan() -> void :
	$MeshInstance2D.modulate = Color.darkgray

func _lepas() -> void :
	$MeshInstance2D.modulate = Color.white
