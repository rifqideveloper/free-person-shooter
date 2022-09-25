extends OptionButton

func _ready():
	add_item("512 x 300")	
	add_item("1024 x 600")
	add_item("1280 x 720")
	add_item("1920 x 1080")
	add_item("2560 x 1440")
	add_item("3840 x 2160")	
	var file : File = File.new()
	if file.file_exists("user://setingan.dat") :
		file.open("user://setingan.dat",File.READ_WRITE)
		var v = file.get_var(true)
		if v.resolusi == Vector2(1024,600) :
			set_selected(0)
		elif v.resolusi == Vector2(1024,600) :
			set_selected(1)
		elif v.resolusi == Vector2(1280,720) :
			set_selected(2)
		elif v.resolusi == Vector2(1920,1080) :
			set_selected(3)
		elif v.resolusi == Vector2(2560,1440) :
			set_selected(4)
		elif v.resolusi == Vector2(3840,2160) :
			set_selected(5)
		else:
			OS.set_window_size(Vector2(1024,600))
			v.resolusi = Vector2(1024,600)
			file.store_var(v)
			set_selected(1)
	else :
		pass
	file.close()
func set_selected(Index:int) -> void:
	select(Index)
	
func _on_OptionButton_item_selected(index):
	if index == 0 :
		OS.set_window_size(Vector2(512,300))
		$"../../../../../..".setingan.resolusi = Vector2(512,300)
	elif index == 1 :
		OS.set_window_size(Vector2(1024,600))
		$"../../../../../..".setingan.resolusi = Vector2(1024,600)		
	elif index == 2:
		OS.set_window_size(Vector2(1280,720))	
		$"../../../../../..".setingan.resolusi = Vector2(1280,720)		
	elif index == 3:		
		OS.set_window_size(Vector2(1920 ,1080))	
		$"../../../../../..".setingan.resolusi = Vector2(1920 ,1080)		
	elif index == 4:
		OS.set_window_size(Vector2(2560 ,1440))	
		$"../../../../../..".setingan.resolusi = Vector2(2560 ,1440)		
	elif index == 5:
		OS.set_window_size(Vector2(3840  ,2160))
		$"../../../../../..".setingan.resolusi =Vector2(3840  ,2160)				
	else:
		var error = load("res://scene/error.tscn").instance()
		error.pesan = "option_resolution_option?"
		print_debug(index)
		add_child(error)
	var file : File = File.new()
	file.open("user://setingan.dat",File.WRITE)
	file.store_var($"../../../../../..".setingan)
	file.close()
			
		
