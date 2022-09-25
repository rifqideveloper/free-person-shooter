extends Tabs

func _ready() -> void:
	$VBoxContainer/keyboard.connect("toggled",self,"_keyboard")
	$VBoxContainer/mobile.connect("toggled",self,"_mobile")
	
func _keyboard(tekan:bool) -> void :
	var file : File = File.new()
	file.open("user://setingan.dat",File.WRITE_READ)
	var data = file.get_var(true)
	data["keyboard"] = tekan
	file.store_var(data)
	file.close()
		
func _mobile(tekan:bool) -> void :
	var file : File = File.new()
	file.open("user://setingan.dat",File.WRITE_READ)
	var data = file.get_var(true)
	data["mobile_constroler"] = tekan
	#file.store_var(data)
	file.close()

	
