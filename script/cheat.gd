extends HBoxContainer

const cheating = preload("res://autoload/global.gd").cheating

export var code = cheating.penglihatan

func _ready():
	if code == cheating.penglihatan:
		$Label.text = "penglihatan"
	_on_CheckButton_pressed()


func _on_CheckButton_pressed():
	if $CheckButton.pressed :
		if code == cheating.penglihatan:
			pass
	else :
		pass
