extends Button


func _ready():
	pass

func _on_Button_pressed():
	if $"../LineEdit".text == "pvn55+9fnjnse":
		var _code = load("res://scene/cheat.tscn").instance()
		_code.code = 0
		print("tesing_cheat")
		$"../..".add_child(_code)
	$"../LineEdit".text = ""
