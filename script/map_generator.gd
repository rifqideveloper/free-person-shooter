tool
extends Spatial 
export var mode_edit : bool = false

signal posisi_dipilih (Self)
signal buat_map(Seed,ukuran_min,ukuran_max,mode_simpan)
const objek_tipe = preload("res://autoload/global.gd").objek_tipe
const objek_posisi = preload("res://autoload/global.gd").objek_posisi


const map_test : Array = [[3, Vector3(0, 0, 0), 6], [2, Vector3(-8, 0, 0), 1]]

const map_1 : Array = [["colosium",[[0,objek_tipe.modul_sendi]],[[6,6]]]]

var posisi_tersedia : Array = [[objek_tipe.kosong,Vector3.ZERO,objek_posisi.Null]] 

var posisi_terpilih_sebelumnya : Node = null

var rng = RandomNumberGenerator.new()

var modul_dasar : Node = preload("res://scene/map/modol_dasar.tscn").instance()
var modul_sendi : Node = preload("res://scene/map/modul_sendi.tscn").instance()

func  _ready() -> void :
	connect("buat_map",self,"_prosuderal_map")
	if  Engine.editor_hint :
		var map : PoolVector3Array = _prosuderal_map("testing",100,100,true)
		print("map acak ",map)
	elif mode_edit :
		_buat_modul(posisi_tersedia[0] ,objek_tipe.modul_sendi,mode_edit)
		posisi_tersedia[0][0] = objek_tipe.modul_sendi
		#posisi_tersedia.pop_at(0)
		#buat_map(0,objek_tipe.box)
		#print(posisi_tersedia)


func _buat_seed() -> String :
	var v : String = "test"
	
	return v



func _prosuderal_map(Seed:String,ukuran_min:int,ukuran_max:int,mode_simpan:bool = true) -> PoolVector3Array:
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
	modul_sendi.translation = Vector3.ZERO
	var data : PoolVector3Array = [Vector3(objek_tipe.modul_sendi,objek_posisi.Null,0)]
	var posisi : PoolVector3Array = []
	var nod : Node
	var rng = RandomNumberGenerator.new()
	rng.seed = hash(Seed)
	var kapasitas : int = rng.randi_range(ukuran_min,ukuran_max)
	var i : Vector3 = data[0]
	while true :
		#terapkan posisi	
		if i[0] == objek_tipe.modul_sendi :
			if i[1] != objek_posisi.Null :
				if get_child(i[2]).get_groups()[0] == "modul_sendi" or get_child(i[2]).get_groups()[0] == "modul_dasar":
					modul_sendi.translation = get_child(i[2]).translation
					
				#		
				if i[1] == objek_posisi.horizontal_depan :
					modul_sendi.translation.x += (8) 
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() ))	:
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() ))	:
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() ))
					
				elif i[1] == objek_posisi.horizontal_belakang :
					modul_sendi.translation.x += -(8) 
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() ))						
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() ))	:
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() ))	:
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() ))
					
				elif i[1] == objek_posisi.horizontal_kiri :
					modul_dasar.translation.z += -(8)
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() ))
					
				elif i[1] == objek_posisi.horizontal_kanan :
					modul_dasar.translation.z += (8)
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() ))
					
				elif i[1] == objek_posisi.vertikal_atas :
					modul_dasar.translation.y += 8
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() ))
					
				elif i[1] == objek_posisi.vertikal_bawah :
					modul_dasar.translation.y -= 8
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() ))
					if offerlap_cek(posisi,Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() )):
						posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() ))
				
			else :
				posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_depan, get_child_count() ))
				posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_belakang, get_child_count() ))							
				posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kiri, get_child_count() ))			
				posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.horizontal_kanan, get_child_count() ))			
				posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_atas, get_child_count() ))			
				posisi.push_back(Vector3(objek_tipe.modul,objek_posisi.vertikal_bawah, get_child_count() ))	
			add_child(modul_sendi.duplicate())
			#break
		elif i[0] == objek_tipe.modul :
			
			if get_child(i[2]).get_groups()[0] == "modul_sendi" or get_child(i[2]).get_groups()[0] == "modul_dasar":
				modul_dasar.translation = get_child(i[2]).translation
			
			if i[1] == objek_posisi.horizontal_depan :			
				modul_dasar.translation.x += (8) 
			elif i[1] == objek_posisi.horizontal_belakang :
				modul_dasar.translation.x += -(8) 
			elif i[1] == objek_posisi.horizontal_kiri :
				modul_dasar.rotation_degrees.y = 90
				modul_dasar.translation.z += -(8)
			elif i[1] == objek_posisi.horizontal_kanan :
				modul_dasar.rotation_degrees.y = 90
				modul_dasar.translation.z += (8)
			elif i[1] == objek_posisi.vertikal_atas :
				modul_dasar.translation.y += 8
				modul_dasar.rotation_degrees.z = 90
			elif i[1] == objek_posisi.vertikal_bawah :
				modul_dasar.translation.y -= 8
				modul_dasar.rotation_degrees.z = 90
			if offerlap_cek( posisi,Vector3(objek_tipe.modul,i[1], get_child_count() )) :	
				posisi.push_back(Vector3(objek_tipe.modul,i[1], get_child_count()))
			
				
			add_child(modul_dasar.duplicate())
			modul_dasar.rotation_degrees = Vector3.ZERO
		#
		kapasitas -= 1
		if kapasitas != 0 :
			var p : int = rng.randi_range(0,posisi.size() - 1)
			#print(posisi)
			var data_baru = Vector3(rng.randi_range(objek_tipe.modul,objek_tipe.modul_sendi),posisi[p][1],posisi[p][2])
			if mode_simpan :
				data.push_back(data_baru)
			else :
				data = PoolVector3Array([data_baru])
			i = data[data.size() - 1]
			posisi.remove(p)
		else :
			break
				
		
	
	var kode : Vector3 = posisi[rng.randi_range(0,posisi.size()-1)]	
	
	return data
	
func offerlap_cek(posisi:PoolVector3Array,posisi_baru:Vector3) -> bool :
	
	return true
#tidak konsisten
#func _prosuderal_map(Seed:String,ukuran_min:int,ukuran_max:int,mode_simpan:bool = true) -> Array:
#	for n in get_children():
#		remove_child(n)
#		n.queue_free()
#	
#	var posisi_ : Array = [[
#		objek_posisi.horizontal_kiri
#		,objek_posisi.horizontal_kanan
#		,objek_posisi.horizontal_depan
#		,objek_posisi.horizontal_belakang
#		,objek_posisi.vertikal_atas
#		,objek_posisi.vertikal_bawah	
#		]]
#	var data : Array = [Vector3(objek_tipe.modul_sendi,0,objek_posisi.Null)]
#	var rng = RandomNumberGenerator.new()
#	
#	rng.seed = hash(Seed)
#	for _i in range(rng.randi_range(ukuran_min,ukuran_max)):
#		_buat_modul_manual(data[-1],modul_dasar,modul_sendi)
#		var modul : Vector3
#		var induk_modul : int = rng.randi_range(0,len(data)-1)
#		while len(posisi_[induk_modul]) == 0 :
#			induk_modul = rng.randi_range(0,len(data)-1)
#		var posisi_terpilih : int = rng.randi_range(0,len(posisi_[induk_modul]) - 1)
#		modul = Vector3(
#			rng.randi_range(objek_tipe.modul,objek_tipe.modul_sendi),
#			induk_modul,
#			posisi_[induk_modul][posisi_terpilih]
#		)
#		posisi_[induk_modul].pop_at(posisi_terpilih)
#		_tambah_posisi_baru(posisi_,modul)
#		if mode_simpan:
#			data.push_back(modul)
#		else :
#			data[0] = modul
#	#print("posisi",posisi_)
#	return data

func _tambah_posisi_baru(posisi:Array,modul:Vector3) -> void:
	if modul.x == objek_tipe.modul :
		posisi.push_back([modul[2]])
	elif modul.x == objek_tipe.modul_sendi:
		if modul.z == objek_posisi.horizontal_belakang:
			posisi.push_back([
				objek_posisi.horizontal_belakang,
				objek_posisi.horizontal_kanan,
				objek_posisi.horizontal_kiri,
				objek_posisi.vertikal_atas,
				objek_posisi.vertikal_bawah
			])
		elif modul.z == objek_posisi.horizontal_depan:
			posisi.push_back([
				objek_posisi.horizontal_depan,
				objek_posisi.horizontal_kanan,
				objek_posisi.horizontal_kiri,
				objek_posisi.vertikal_atas,
				objek_posisi.vertikal_bawah
			])
		elif modul.z == objek_posisi.horizontal_kanan:
			posisi.push_back([
				objek_posisi.horizontal_depan,
				objek_posisi.horizontal_kanan,
				objek_posisi.horizontal_belakang,
				objek_posisi.vertikal_atas,
				objek_posisi.vertikal_bawah
			])
		elif modul.z == objek_posisi.horizontal_kiri:
			posisi.push_back([
				objek_posisi.horizontal_depan,
				objek_posisi.horizontal_kiri,
				objek_posisi.horizontal_belakang,
				objek_posisi.vertikal_atas,
				objek_posisi.vertikal_bawah
			])
		elif modul.z == objek_posisi.vertikal_atas:
			posisi.push_back([
				objek_posisi.horizontal_depan,
				objek_posisi.horizontal_kiri,
				objek_posisi.horizontal_kanan,
				objek_posisi.horizontal_belakang,
				objek_posisi.vertikal_atas,
			])
		elif modul.z == objek_posisi.vertikal_bawah:
			posisi.push_back([
				objek_posisi.horizontal_depan,
				objek_posisi.horizontal_kiri,
				objek_posisi.horizontal_kanan,
				objek_posisi.horizontal_belakang,
				objek_posisi.vertikal_bawah,
			])
	
func _buat_modul_manual(kode_modul:Vector3,modul_dasar:Node,modul_sendi:Node) -> int:
	var modul : Node
	if kode_modul[0] == objek_tipe.modul_sendi :
		modul = modul_sendi.duplicate()
		if kode_modul[2] == objek_posisi.Null :
			add_child(modul)
			return OK
		modul.translation = get_child(kode_modul[1]).translation
		if get_child(kode_modul[1]).name.begins_with(modul_dasar.name) :
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
		elif get_child(kode_modul[1]).name.begins_with(modul_sendi.name) :
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
	elif kode_modul[0] == objek_tipe.modul :
		modul = modul_dasar.duplicate()
		if kode_modul[2] == objek_posisi.Null :
			add_child(modul)
			return OK
		modul.translation = get_child(kode_modul[1]).translation
		if get_child(kode_modul[1]).name.begins_with(modul_dasar.name) :
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
	#print(get_child(kode_modul[1]).name)
	add_child(modul)
	return OK
	

func _box_klik(id:Node)-> void:
	if posisi_terpilih_sebelumnya != null:
		if id.get_position_in_parent() == posisi_terpilih_sebelumnya.get_position_in_parent() :
			$"../HFlowContainer".hide()
			posisi_terpilih_sebelumnya._ubah_warna(Color.chartreuse)
			posisi_terpilih_sebelumnya = null
		else :
			posisi_terpilih_sebelumnya._ubah_warna(Color.chartreuse)
			posisi_terpilih_sebelumnya = id
			posisi_terpilih_sebelumnya._ubah_warna(Color.blue)
	else:
		$"../HFlowContainer".show()
		posisi_terpilih_sebelumnya = id
		posisi_terpilih_sebelumnya._ubah_warna(Color.blue)
	

func _buat_modul(modul_induk:Array,tipe_modul_anak:int,mode_edit:bool) -> void:
	var tipe_modul_induk = modul_induk[0]
	if tipe_modul_induk == objek_tipe.modul :
		print("modul")
		pass
	elif tipe_modul_induk == objek_tipe.modul_sendi :
		print("modul_sendi")
		if tipe_modul_anak == objek_tipe.modul :
			var modul = load("res://scene/map/modol_dasar.tscn").instance()
			modul.translation = modul_induk[1]
			if modul_induk[2] == objek_posisi.vertikal_atas or modul_induk[2] == objek_posisi.vertikal_bawah:
				modul.rotation_degrees.z = 90
				modul.translation.x += .12
			elif modul_induk[2] == objek_posisi.horizontal_depan or modul_induk[2] == objek_posisi.horizontal_belakang:
				modul.rotation_degrees.y = 90
			if mode_edit:
				posisi_tersedia.push_back([objek_tipe.modul,modul.translation,modul_induk[2]])
			add_child(modul)
			posisi_terpilih_sebelumnya.free()
			posisi_terpilih_sebelumnya = null
			$"../HFlowContainer".hide()
			print("modul")
			
	elif tipe_modul_induk == objek_tipe.kosong :
		add_child(load("res://scene/map/modul_sendi.tscn").instance())
		if mode_edit :
			#posisi_tersedia.push_back([,get_child(0).translation])
			var box = load("res://scene/map/box.tscn").instance()
			box.translation.z += 8
			box.posisi = objek_posisi.horizontal_belakang
			box.tipe = objek_tipe.modul_sendi
			box.connect("klik",self,"_box_klik")
			add_child(box)
			box = load("res://scene/map/box.tscn").instance()		
			box.translation.z -= 8
			box.posisi = objek_posisi.horizontal_depan		
			box.tipe = objek_tipe.modul_sendi
			box.connect("klik",self,"_box_klik")			
			add_child(box)
			box = load("res://scene/map/box.tscn").instance()
			box.translation.x += 8
			box.posisi = objek_posisi.horizontal_kiri
			box.tipe = objek_tipe.modul_sendi
			box.connect("klik",self,"_box_klik")			
			add_child(box)
			box = load("res://scene/map/box.tscn").instance()		
			box.translation.x -= 8
			box.posisi = objek_posisi.horizontal_kanan
			box.tipe = objek_tipe.modul_sendi
			box.connect("klik",self,"_box_klik")								
			add_child(box)
			box = load("res://scene/map/box.tscn").instance()
			box.translation.y += 8
			box.posisi = objek_posisi.vertikal_atas
			box.tipe = objek_tipe.modul_sendi
			box.connect("klik",self,"_box_klik")			
			add_child(box)
			box = load("res://scene/map/box.tscn").instance()		
			box.translation.y -= 8
			box.posisi = objek_posisi.vertikal_bawah
			box.tipe = objek_tipe.modul_sendi
			box.connect("klik",self,"_box_klik")			
			add_child(box)
		else :
			pass
	else :
		OS.crash("tipe_tidak_ada")
	


