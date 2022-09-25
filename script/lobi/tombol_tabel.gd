extends Button
enum posisi {
	netral
	atas
	bawah
}
signal atur_posisi (index,nilai)

var icon_gambar = posisi.netral
export var index : int = 0
func _ready():
	pass

func _on_Button_pressed():
	if icon_gambar != 2:
		icon_gambar += 1
	else :
		icon_gambar = 0 

	if icon_gambar == 0:
		icon = load("res://posisi_dasar(1).webp")
	elif icon_gambar == 1:
		icon = load("res://posisi_atas.webp")
	elif icon_gambar == 2:
		icon = load("res://posisi_bawah.webp")
	emit_signal("atur_posisi",index,icon_gambar)
		
