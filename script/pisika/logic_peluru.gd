extends RigidBody
const tipe_munisi = preload("res://autoload/global.gd").tipe_amunisi
export(tipe_munisi) var tipe_peluru = tipe_munisi.HE_GRO_55
export var akselerasi : float
export var kecepatan : float

func _ready() -> void:
	$VisibilityEnabler.connect("camera_entered",self,"_terlihat")
	$VisibilityEnabler.connect("camera_exited",self,"tidak_terlihat")

func _terlihat(c:Camera) -> void :
	visible = true

func tidak_terlihat(c:Camera) -> void :
	visible = false

func _maju() -> void:
	set_as_toplevel(true)
	match tipe_peluru :
		_:
			pass

func _physics_process(delta):
	if is_set_as_toplevel() :
		kecepatan += akselerasi
		apply_impulse(transform.basis.x, (transform.basis.x * kecepatan))

func _on_Area_body_entered(body:Node):
	if body.is_in_group("player") :
		body.emit_signal("kena_tembak",1)
		#print("kena")
	queue_free()

