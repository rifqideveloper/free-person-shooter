extends Node


func _ready():
	var f = File.new()
	if f.file_exists("res://website/index.pck") :
		var sha = f.get_sha256("res://website/index.pck")
		if f.open("res://website/index.sha256",File.WRITE) == OK :
			f.store_string(sha)
	f.close()
	get_tree().quit(0)
