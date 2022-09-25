extends StaticBody

signal klik (id)

export var posisi : int 
export var tipe : int 

func _ready():
	_ubah_warna(Color.chartreuse)
	
func _on_box_input_event(camera, event, position, normal, shape_idx):
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		_ubah_warna(Color.blue)
		#print("klik")
		emit_signal("klik",self)
		
func _ubah_warna(warna)-> void:
	var new_material = SpatialMaterial.new()
	new_material.set_albedo(warna)
	$MeshInstance.set("material/0", new_material)

func _data() -> Array:
	return [tipe,translation,posisi]
