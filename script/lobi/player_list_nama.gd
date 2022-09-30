extends HBoxContainer

export var data : Array
const tipe_player = preload("res://autoload/global.gd").tipe_ruang
func _ready():
	$Label.text = data[0]
	if data[1] != tipe_player.master_server :
		if data[1] != tipe_player.Master :
			$server.queue_free()
			
		if data[1] != tipe_player.Server :
			$master.queue_free()
	if data[2] == 0 :
		$siap.queue_free()
	else :
		$tunggu.queue_free()
	
	if !data[3] :
		$cheat.queue_free()

