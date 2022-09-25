extends Node
class_name pergerakan_standar

var _Thread : Array 
var _mulai_Thread : bool = true

func _init(object:Node,akselerasi:float,massa:float,grafitasi:bool = false) -> void:
	var v : Thread = Thread.new()
	v.start(self,"_kiri_kanan",null,Thread.PRIORITY_HIGH)
	_Thread.push_back([Semaphore.new(),v])
	if grafitasi :
		pass

func _kiri_kanan() -> void:
	pass

func _mulai() -> void:
	pass
	
func _lanjut() -> void:
	for i in _mulai_Thread:
		i[0].post()
		
func _grafiti_stop() -> void:
	pass
func _grafiti_start() -> void:
	pass

func _keluar() -> void:
	_mulai_Thread = false
	for i in _Thread:
		i[0].post()
		i[1].wait_to_finish()
