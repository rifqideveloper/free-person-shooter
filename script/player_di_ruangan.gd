extends HBoxContainer

export var team_2 : bool = false 
export var nama : String = "error"
func _ready():
	
	if !team_2:
		add_child(Label.new())
		get_child(0).text = nama
		add_child(Button.new())
		get_child(1).icon = load("res://icon_godot.webp")
		get_child(1).flat = true
	else:
		add_child(Button.new())
		get_child(0).icon = load("res://icon_godot.webp")
		get_child(0).flat = true
		add_child(Label.new())
		get_child(1).text = nama
		
