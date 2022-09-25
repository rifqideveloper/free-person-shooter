

class_name standar_map

var kode_modul : Vector3
var node : Node
func _init(modul : Vector3,objek : Node ):
	kode_modul = modul
	node = objek

func buat_standar() -> int:
	node.get_children().clear()
	var modul_dasar : Node = preload("res://scene/map/modol_dasar.tscn").instance() 
	var modul_sendi : Node = preload("res://scene/map/modul_sendi.tscn").instance()
	var modul : Node
	if kode_modul[0] == objek_tipe.modul_sendi :
		modul = modul_sendi.duplicate()
		if kode_modul[2] == objek_posisi.Null :
			add_child(modul)
			#continue
		modul.translation = node.get_child(kode_modul[1]).translation
		if node.get_child(kode_modul[1]).name.begins_with(modul_dasar.name) :
			if kode_modul[2] == objek_posisi.horizontal_kiri :
				modul.translation.z += 8
			elif kode_modul[2] == objek_posisi.horizontal_kanan :
				modul.translation.z -= 8
			elif kode_modul[2] == objek_posisi.horizontal_belakang :
				modul.translation.x += 8
			elif kode_modul[2] == objek_posisi.horizontal_depan :
				modul.translation.x -= 8
			elif kode_modul[2] == objek_posisi.vertikal_atas :
				modul.translation.y += 8
					#modul.rotation_degrees.z = 90
			elif kode_modul[2] == objek_posisi.vertikal_bawah :
				modul.translation.y -= 8
					#modul.rotation_degrees.z = 90
		elif node.get_child(kode_modul[1]).name.begins_with(modul_sendi.name) :
			if kode_modul[2] == objek_posisi.horizontal_kiri :
				modul.translation.z += 8.8
			elif kode_modul[2] == objek_posisi.horizontal_kanan :
				modul.translation.z -= 8.8
			elif kode_modul[2] == objek_posisi.horizontal_belakang :
				modul.translation.x += 8.8
			elif kode_modul[2] == objek_posisi.horizontal_depan :
				modul.translation.x -= 8.8
			elif kode_modul[2] == objek_posisi.vertikal_atas :
				modul.translation.y += 8.8
					#modul.rotation_degrees.z = 90
			elif kode_modul[2] == objek_posisi.vertikal_bawah :
				modul.translation.y -= 8.8
					#modul.rotation_degrees.z = 90
		elif kode_modul[0] == objek_tipe.modul :
			modul = modul_dasar.duplicate()
			if kode_modul[2] == objek_posisi.Null :
				add_child(modul)
				#continue
			modul.translation = get_child(kode_modul[1]).translation
			if node.get_child(kode_modul[1]).name.begins_with(modul_dasar.name) :
				if kode_modul[2] == objek_posisi.horizontal_kiri :
					modul.translation.z += 8
					modul.rotation_degrees.y = 90
				elif kode_modul[2] == objek_posisi.horizontal_kanan :
					modul.translation.z -= 8
					modul.rotation_degrees.y = 90
				elif kode_modul[2] == objek_posisi.horizontal_belakang :
					modul.translation.x += 8
				elif kode_modul[2] == objek_posisi.horizontal_depan :
					modul.translation.x -= 8
				elif kode_modul[2] == objek_posisi.vertikal_atas :
					modul.translation.y += 8
					#modul.rotation_degrees.z = 90
				elif kode_modul[2] == objek_posisi.vertikal_bawah :
					modul.translation.y -= 8.8
			elif get_child(kode_modul[1]).name.begins_with(modul_sendi.name) :
				if kode_modul[2] == objek_posisi.horizontal_kiri :
					modul.translation.z += 8
					modul.rotation_degrees.y = 90
				elif kode_modul[2] == objek_posisi.horizontal_kanan :
					modul.translation.z -= 8
					modul.rotation_degrees.y = 90
				elif kode_modul[2] == objek_posisi.horizontal_belakang :
					modul.translation.x += 8
				elif kode_modul[2] == objek_posisi.horizontal_depan :
					modul.translation.x -= 8
				elif kode_modul[2] == objek_posisi.vertikal_bawah :
					modul.translation.y -= 8
					modul.rotation_degrees.z = 90					
				else :
					modul.translation.y += 8.6
					modul.rotation_degrees.z = 90
			
		if modul.translation == Vector3.ZERO:
			print_debug("salah posisi ",kode_modul)
		print(get_child(kode_modul[1]).name)
		node.add_child(modul)
	return OK
