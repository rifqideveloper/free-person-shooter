extends CanvasLayer

onready var code_map : Array 

func _ready() -> void:
	for i in $map_generator.map_1 :
		$OptionButton.add_item(i[0])
	$OptionButton.emit_signal("item_selected",0)
	if !OS.has_feature("editor"):
		$Label.free()
		

func _on_OptionButton_item_selected(index:int) -> void:
	code_map = $map_generator.map_1[index][1]
	#$map_generator.kode_map(index)
	#$".".emit_signal("script_changed")

func _debug()->void:
	print($Label.text)

