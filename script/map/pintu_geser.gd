tool
extends StaticBody

export var lebar_bukaan : float = 2


func _process(delta):
	if Engine.editor_hint:
		buka_(lebar_bukaan)

func buka_(z:float)->void:
	get_child(0).translation.z += -z
	get_child(1).translation.z += z
func tutup_(z:float)->void:
	get_child(0).translation.z -= -z
	get_child(1).translation.z -= z

