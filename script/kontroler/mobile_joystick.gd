extends Node2D

func tidak_melebihi_batas(x_y:float) -> bool:
	return !(x_y < 20 or x_y > -20)

func _ready():
	pass
	
func _process(delta) -> void:
	pass
	#print("jotstick ",$TouchScreenButton.bitmask)

func _on_TouchScreenButton_pressed():
	$TouchScreenButton/MeshInstance2D.modulate = Color.crimson
	
func _on_TouchScreenButton_released():
	$TouchScreenButton/MeshInstance2D.modulate = Color.white
