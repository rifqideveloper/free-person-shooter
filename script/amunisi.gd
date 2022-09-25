extends Node2D
tool
const tinggi : float = 30.0
const lebar : float = 10.0
const posisi : Vector2 = Vector2(-30,32)

const mode_tembak = preload("res://autoload/global.gd").mode_tembak

func _ready() -> void :
	if Engine.editor_hint:
		_on_senjata_magazi_diatur_ulang([[0,30,30],[0,30,30]])

func _on_senjata_magazi_diatur_ulang(mag:Array) -> void:
	#print("test")
	$"../../senjata/gcu/info".text = str(mag[0][2]) + "\n"
	match $"../../senjata".mode_senjata :
		mode_tembak.auto :
			$"../../senjata/gcu/info".text += "auto"
		mode_tembak.semi :
			$"../../senjata/gcu/info".text += "semi"				
		mode_tembak.trio :
			$"../../senjata/gcu/info".text += "trio"
			
	if mag[0][2] == 0 :
		$"../../senjata/gcu/info".modulate = Color.red
	elif mag[0][2] < (mag[0][1] / 2) :
		$"../../senjata/gcu/info".modulate = Color.yellow		
	else :
		$"../../senjata/gcu/info".modulate = Color.green
		
	if get_child_count() < mag.size():
		var node : Node = MeshInstance2D.new()
		node.mesh = CubeMesh.new()
		node.scale.x = lebar
		node.modulate = Color.green
		for i in range(mag.size() - get_child_count()) :
			add_child(node.duplicate())
	elif get_child_count() > mag.size():		
		for i in range( get_child_count() - mag.size() ) :
			var v = get_child( get_child_count() - 1 )
			remove_child( v )
			v.queue_free()
	for i in range( mag.size()  ):
		var node : Node = get_child(i)
		node.scale.y = tinggi / ( float(mag[i][1])  / floor(mag[i][2])  )
		node.position = Vector2(posisi.x * i, (node.scale.y - tinggi) * -1)
		
