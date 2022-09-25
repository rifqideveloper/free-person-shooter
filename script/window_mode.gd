extends OptionButton

func _ready():
	add_item("fullscreen")
	add_item("borderless")
	add_item("window")
	select( get_node("/root/Global").cek_data()["window_mode"] )

func _on_OptionButton_item_selected(index):
	OS.window_fullscreen = index == 0 or index == 1
	OS.window_borderless = index == 1
	var file : File = File.new()
	if file.file_exists("user://setingan.dat") :
		file.open("user://setingan.dat",File.READ_WRITE)
		var v = file.get_var()
		v.window_mode = index
		file.store_var(v)
	file.close()
		
	#select(index)
	
