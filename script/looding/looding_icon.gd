extends Sprite
tool
enum posisi_loding_icon {
	bawah_kiri
	bawah_kanan
	atas_kiri
	atas_kanan
}

func _ready():
	pass

func _physics_process(delta):
	if Engine.editor_hint :
		rotate(-0.1)
	else :
		rotate(-0.1)
