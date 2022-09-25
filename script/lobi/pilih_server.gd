extends Button

var data : Array = [10,"id","000","test",[6,6],"111.11.1"]

func tombol_ditekan()-> void:
	print("testing")
	
func _ready() -> void:
	#test
	masukan_data(data)
	connect("pressed",self,"tombol_ditekan")

func masukan_data(data_masuk:Array) -> void:
	data = data_masuk
	
	text = str(data[0]) 
	
	text += ""
	
	text += data[1]
	
	text += data[2]
	
	text += data[3] 
	
	text += str(data[4][0]) + "/" + str(data[4][0])  

func data_terima() -> Array:
	return data
