extends KinematicBody
signal mouse (event)
signal koleksi_input
var mouse_sens : float = 0.3
const akselerasi : float = 0.01
var pergerakan : Vector3 = Vector3.ZERO
var rotasi_data : Vector3 = Vector3.ZERO 
#var r_x : float 
#var r_y  : float
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	connect("mouse",self,"_mouse_input")
	connect("koleksi_input",self,"_tembak")
	connect("koleksi_input",self,"_input_lain")	
	connect("koleksi_input",self,"_pergerakan",[2,"ui_down","ui_up"])
	connect("koleksi_input",self,"_pergerakan_2",[1,"ui_select","_ui_duduk"])
	connect("koleksi_input",self,"_pergerakan_3",[0,"ui_right","ui_left"])
	connect("koleksi_input",self,"_putar",["ui_rotasi_kanan","ui_rotasi_kiri"])
	#
	$senjata.connect("magazi_diatur_ulang",$player_ui/amunisi,"_on_senjata_magazi_diatur_ulang",[$senjata.magazin])
	#debug
	if true :
		connect("koleksi_input",self,"_debug")
	
func _mouse_input(event) -> void :
	var r_x = deg2rad( -event.relative.x * mouse_sens) 
	var r_y = deg2rad( -event.relative.y * mouse_sens) 
	rotate_y(r_x)
	rotate_x(r_y)
	rotation_degrees.z = 0

func _menu_keluar() -> void :
	var v : Node = get_child(6)
	remove_child(v)
	v.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func keluar_dari_arena() -> void :
	pass

func _input_lain() -> void:
	if Input.is_action_pressed("ui_exite_"):
		OS.crash("dipaksa keluar oleh player")
	elif Input.is_action_just_pressed("ui_cancel") :
		if get_child_count() == 6 :
			var menu : Node = preload("res://scene/menu.tscn").instance()
			menu.main = false
			menu.connect("lanjut",self,"_menu_keluar")
			menu.connect("keluar_dari_arena",self,"_keluar_arena")
			menu.connect("mobile_activ",$player_ui,"modile_mode")
			add_child(menu)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else :
			_menu_keluar()
			
	if Input.is_action_just_pressed("ui_focus_next"):
		$player_ui/score.visible = true
	elif  Input.is_action_just_released("ui_focus_next"):
		$player_ui/score.visible = false
	if  Input.is_action_just_released("ui_ubah_mode_tembak"):
		$senjata.emit_signal("ubah_mode")

func _tembak() -> void :
	if Input.is_action_pressed("ui_tembak") and get_child_count() == 6:
		$senjata.emit_signal("tembak")
		
func _pergerakan(index:int,x:String,y:String) -> void:
	var v : int = Input.get_action_strength(x) - Input.get_action_strength(y)
	if v == 0:
		pergerakan[index] = lerp(pergerakan[index],0,akselerasi)
		return
	pergerakan[index] += akselerasi * v
	
func _pergerakan_2(index:int,x:String,y:String) -> void:
	var v : int = Input.get_action_strength(x) - Input.get_action_strength(y)
	if v == 0:
		pergerakan[index] = lerp(pergerakan[index],0,akselerasi)
		return
	pergerakan[index] += akselerasi * v

func _pergerakan_3(index:int,x:String,y:String) -> void:
	var v : int = Input.get_action_strength(x) - Input.get_action_strength(y)
	if v == 0:
		pergerakan[index] = lerp(pergerakan[index],0,akselerasi)
		return
	pergerakan[index] += akselerasi * v
	
func _putar(x:String,y:String) -> void :
	rotasi_data.z = lerp(rotasi_data.z,0.05*(Input.get_action_strength(x)-Input.get_action_strength(y)),akselerasi)
	rotate_z(rotasi_data.z)
	
func _debug()->void:
	$player_ui/debug.text  = "fps : " + str(Engine.get_frames_per_second()) + "\n"
	$player_ui/debug.text += "pergerakan : " + str(pergerakan) + "\n"
	$player_ui/debug.text += "rotasi : " + str(rotasi_data) + "\n"
	

func _physics_process(delta) -> void :
	emit_signal("koleksi_input")
	move_and_slide(pergerakan)
	

func _input(event) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion :
		emit_signal("mouse",event)

