extends TabContainer

export var team_2 : bool = false
var player = preload("res://scene/player_di_ruangan.tscn").instance()
func _ready():
	
	player.team_2 = team_2
	$HBoxContainer/VBoxContainer.add_child(player)
		
		
	
