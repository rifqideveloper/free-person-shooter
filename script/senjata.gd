extends StaticBody
signal magazi_diatur_ulang
signal jeda (v,jeda)
signal ubah_mode
signal tembak
var siap_tembak : bool = true
var jeda_tembak : float = 1.0
const tipe_amunisi = preload("res://autoload/global.gd").tipe_amunisi
const mode_tembak = preload("res://autoload/global.gd").mode_tembak

export var magazin : Array = [[tipe_amunisi.HE_GRO_55,30,30],[tipe_amunisi.HE_GRO_55,30,30]]
export (mode_tembak) var mode_senjata : int = mode_tembak.auto

var tunggu = Semaphore.new()
var jeda_mulai = true

func _ready():
	connect("tembak",self,"_tembak")
	connect("jeda",self,"_jeda",[],CONNECT_PERSIST)
	if mode_senjata == mode_tembak.semi :
		$gcu/info.text = str(magazin[0][2]) + "\nsemi"
	elif mode_senjata == mode_tembak.auto :
		$gcu/info.text = str(magazin[0][2]) + "\nauto"
	else :
		$gcu/info.text = str(magazin[0][2]) + "\natrip"		
	
func _ubah_mode() -> void:
	match mode_senjata :
		mode_tembak.semi :
			mode_senjata = mode_tembak.auto
		mode_tembak.auto :
			mode_senjata = mode_tembak.trio
		mode_tembak.trio :
			mode_senjata = mode_tembak.semi
	emit_signal("magazi_diatur_ulang",magazin)
func _tembakin() -> void :
	$magazin.emit_signal("tembak")
	magazin[0][2] -= 1
	emit_signal("jeda",siap_tembak,1000)
	
func _tembak() -> void:
	
	if mode_senjata == mode_tembak.semi :
		siap_tembak = Input.is_action_just_pressed("ui_tembak")
		$gcu/info.text = str(magazin[0][2]) + "\nsemi"
	elif mode_senjata == mode_tembak.auto :
		$gcu/info.text = str(magazin[0][2]) + "\nauto"
		
	if siap_tembak :
		magazin[0][2] -= 1
		$magazin.emit_signal("tembak")
		#yield(get_tree().create_timer(jeda_tembak), "timeout")
		siap_tembak = false
		$Timer.start()
		emit_signal("magazi_diatur_ulang")
	
		
	#if siap_tembak and magazin[0][2] > 0 :
	#	siap_tembak = false
	#	magazin[0][2] -= 1
	#	$magazin.emit_signal("tembak")
	#	$gcu/info.text = str(magazin[0][2])
		#emit_signal("jeda",siap_tembak,1000)
	#	siap_tembak = true
func _jeda(v,jeda) -> void:
	#$gcu/info.text = str(magazin[0][1]) + "/" + str(magazin[0][2])
	#$gcu/info.text += "\n"
	siap_tembak = false
	emit_signal("magazi_diatur_ulang",magazin)
	OS.delay_msec(jeda)
	siap_tembak = true


func _amunisi_habis() -> void:
	if !$"../AudioStreamPlayer".playing :
		var v =  load(get_node("/root/Global").amunisi_habis)
		v.set_loop(false)
		$"../AudioStreamPlayer".stream = v
		$"../AudioStreamPlayer".playing = true
	
#func _physics_process(delta):
#	$gcu/laser._update()


func _on_Timer_timeout():
	siap_tembak = true
	pass # Replace with function body.
