extends KinematicBody
signal tembak
signal bidik
signal menu
signal isi_ulang
signal keluar
signal mati
signal kena_tembak(dmg)
signal rotasi_camera_xy(x,y)
#signal amunisi_habis

const _jenis_baju : Dictionary = preload("res://autoload/global.gd")._jenis_baju
const _jenis_modul_senjata : Dictionary = preload("res://autoload/global.gd")._jenis_modul_senjata
export(_jenis_baju) var baju : int = 0
export(Array,_jenis_modul_senjata) var _modul_senjata : Array = [[_jenis_modul_senjata.pistol]]
export var darah : float = 100.0
export var jira : float = 0

var mouse_sens : float = 0.3
var camera_anglev : float =0
var pergerakan : Vector3 = Vector3.ZERO
const akselerasi : float = 0.01
var rotasi_data : Vector3 = Vector3.ZERO
var r_x : float
var r_y : float

var tunggu_mouse_ : Semaphore = Semaphore.new()
var tunggu_cencel_ : Semaphore = Semaphore.new()
var tunggu_maju_mundur : Semaphore = Semaphore.new()
var tunggu_kiri_kanan : Semaphore = Semaphore.new()
var tunggu_rotasi : Semaphore = Semaphore.new()
var tunggu_atas_bawah : Semaphore = Semaphore.new()
var tunggu_perintah_ke_senjata : Semaphore =  Semaphore.new()

var mulai : bool = true 
var T_ui_cancel : Thread = Thread.new()
var T_maju_mundur : Thread = Thread.new()
var T_kiri_kanan : Thread = Thread.new()
var T_rotasi : Thread = Thread.new()
var T_atas_bawah : Thread = Thread.new()
var T_perintah_ke_senjata : Thread = Thread.new()
var T_mouse : Thread = Thread.new()


onready var camera_rotasi_max : Vector3 = $Camera.rotation

func _keluar():
	#mulai = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print("keluar")
	#emit_signal("mati")
	#queue_free()
func _keluar_arena():
	emit_signal("keluar")

func _perintah_ke_senjata() -> void:
	while  mulai :
		tunggu_perintah_ke_senjata.wait()
		if get_child_count() != 6:
			continue
		elif Input.is_action_pressed("ui_tembak"):
			emit_signal("tembak")
		elif Input.is_action_pressed("ui_bidik"):
			emit_signal("bidik")
		elif Input.is_action_pressed("ui_isi_ulang"):
			if false :
				emit_signal("isi_ulang")
			else :
				emit_signal("amunisi_habis")
func _pop_node() -> void:
	var menu : Node = get_child(get_child_count()-1)
	if menu != null :
		remove_child(menu)
		menu.queue_free()
	
func _mouse_cap() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _cencel_() -> void:
	var press : bool = true
	while  mulai :
		tunggu_cencel_.wait()
		if Input.is_action_pressed("ui_exite_"):
			OS.crash("dipaksa keluar oleh player")
		elif Input.is_action_just_pressed("ui_cancel") and press:
			press = false
			if get_child_count() == 7 :
				get_child(6).emit_signal("lanjut")
				#_pop_node()
				#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else :
				var menu : Node = preload("res://scene/menu.tscn").instance()
				menu.main = false
				menu.connect("lanjut",self,"_pop_node")
				menu.connect("lanjut",self,"_mouse_cap")
				menu.connect("keluar_dari_arena",self,"_keluar_arena")
				menu.connect("mobile_activ",$player_ui,"modile_mode")
				add_child(menu)
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif Input.is_action_just_released("ui_cancel") and !press:
			press = true
		
		if Input.is_action_just_pressed("ui_focus_next"):
			$player_ui/score.visible = true
		elif  Input.is_action_just_released("ui_focus_next"):
			$player_ui/score.visible = false
		if  Input.is_action_just_released("ui_ubah_mode_tembak"):
			$senjata.emit_signal("ubah_mode")
func _atas_bawah()-> void:
	var v : int
	while  mulai :
		tunggu_atas_bawah.wait()
		v = Input.get_action_strength("ui_select") - Input.get_action_strength("_ui_duduk")
		if v == 0:
			pergerakan.y = lerp(pergerakan.y,0,akselerasi)
			continue		
		#print("test")
		pergerakan.y += akselerasi * v
	

func _maju_mundur() -> void:
	var v : int
	while  mulai :
		tunggu_maju_mundur.wait()
		v = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")		

		if v == 0:
			pergerakan.z = lerp(pergerakan.z,0,akselerasi)
			continue
		pergerakan.z += akselerasi * v
		#if Input.is_action_pressed("ui_up"):
		#	if Input.is_action_pressed("ui_down"):
		#		pergerakan.z = lerp(pergerakan.z,0,akselerasi)
		#	else :
		#		pergerakan.z -= akselerasi
		#elif Input.is_action_pressed("ui_down"):
		#		pergerakan.z += akselerasi
			
func _kiri_kanan() -> void:
	var v : int
	while mulai :
		tunggu_kiri_kanan.wait()
		v = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
		if v  == 0 :
			pergerakan.x = lerp(pergerakan.x,0,akselerasi)
			continue	
		pergerakan.x += akselerasi * v
		#if Input.is_action_pressed("ui_right"):
		#	if Input.is_action_pressed("ui_left"):
		#		pergerakan.x = lerp(pergerakan.x,0,akselerasi)				
		#	else :
		#		pergerakan.x += akselerasi
		#elif Input.is_action_pressed("ui_left"):
		#	pergerakan.x -= akselerasi
func _rotasi() -> void:
	while mulai :
		tunggu_rotasi.wait()
		rotasi_data.z = lerp(rotasi_data.z,0.05*(Input.get_action_strength("ui_rotasi_kanan")-Input.get_action_strength("ui_rotasi_kiri")),akselerasi)
		#if Input.is_action_pressed("ui_rotasi_kiri"):
		#	if Input.is_action_pressed("ui_rotasi_kanan"):
		#		rotasi_data.z = lerp(rotasi_data.z,0,akselerasi)
		#	else :
		#		rotasi_data.z = lerp(rotasi_data.z,-0.05,akselerasi)
		#elif Input.is_action_pressed("ui_rotasi_kanan"):		
		#	rotasi_data.z = lerp(rotasi_data.z,0.05,akselerasi)
func _input_mouse() -> void :
	while mulai :
		tunggu_mouse_.wait()
		r_x = deg2rad( r_x * mouse_sens)
		r_y = deg2rad( r_y * mouse_sens)
		_on_KinematicBody_rotasi_camera_xy(r_x,r_y)
		#emit_signal("rotasi_camera_xy", r_x , r_y )
		

func _ready() -> void:
	#if !load("res://autoload/global.gd").cek_data()["mobile_controler"] :
	_mouse_cap()
	T_ui_cancel.start(self,"_cencel_",null,Thread.PRIORITY_LOW)
	T_maju_mundur.start(self,"_maju_mundur",null,Thread.PRIORITY_HIGH)
	T_kiri_kanan.start(self,"_kiri_kanan",null,Thread.PRIORITY_HIGH)
	T_rotasi.start(self,"_rotasi",null,Thread.PRIORITY_HIGH)
	T_atas_bawah.start(self,"_atas_bawah",null,Thread.PRIORITY_HIGH)
	T_perintah_ke_senjata.start(self,"_perintah_ke_senjata",null,Thread.PRIORITY_HIGH)
	T_mouse.start(self,"_input_mouse",null,Thread.PRIORITY_HIGH)
func _exit_tree() -> void:
	mulai = false	
	tunggu_maju_mundur.post()
	tunggu_cencel_.post()
	tunggu_rotasi.post()
	tunggu_kiri_kanan.post()
	tunggu_atas_bawah.post()
	tunggu_perintah_ke_senjata.post()
	tunggu_mouse_.post()
	if T_ui_cancel.is_active() :
		T_ui_cancel.wait_to_finish()
	if T_maju_mundur.is_active() :
		T_maju_mundur.wait_to_finish()
	if T_kiri_kanan.is_active() :
		T_kiri_kanan.wait_to_finish()
	if T_kiri_kanan.is_active() :
		T_rotasi.wait_to_finish()
	if T_atas_bawah.is_active() :
		T_atas_bawah.wait_to_finish()
	if T_perintah_ke_senjata.is_active() :
		T_perintah_ke_senjata.wait_to_finish()
	if T_mouse.is_active() :
		T_mouse.wait_to_finish()

func _input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and  get_child_count() == 6 and event is InputEventMouseMotion :

		r_x = -event.relative.x
		r_y = -event.relative.y
		tunggu_mouse_.post()
		
		
func _physics_process(delta) -> void:
	
	tunggu_maju_mundur.post()
	tunggu_kiri_kanan.post()
	tunggu_atas_bawah.post()
	tunggu_rotasi.post()
	tunggu_cencel_.post()
	tunggu_perintah_ke_senjata.post()
	move_and_slide(pergerakan)
	$player_ui/debug.text = "pergerakan vector"+str(translation)
	rotate_z(rotasi_data.z)
	$player_ui/debug.text += "\nrotasi vector"+str(rotation_degrees)
	$player_ui/debug.text += "\nfps: " + str(Engine.get_frames_per_second())

func _on_KinematicBody_rotasi_camera_xy(x:float, y:float) -> void:
	
	#if (rotation_degrees.y +x) < 50 and (rotation_degrees.y + x) > -50 :
		#rotation_degrees.y += x
	#	rotate_y(x)
	#if (rotation_degrees.x + y) < 50 and (rotation_degrees.x + y) > -50:
	#	rotate_x(y)
		#rotation_degrees.x += y
	
	rotate_y(x)
	rotate_x(y)
	rotation_degrees.z = 0



