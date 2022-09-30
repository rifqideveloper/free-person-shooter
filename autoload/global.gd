extends Node
signal ubah_grafik(seting)
signal looding_selesai
signal looding

enum looding {
	main
	dasar
	selesai
}

enum tipe_akun {
	local,
	gmail,
	git
}
enum cheating {
	penglihatan = 0
}
enum _jenis_baju {
	dasar
}
enum _jenis_modul_senjata {
	pistol
}
enum objek_tipe {
	kosong = 0
	box 
	modul 
	modul_sendi 
}
enum objek_posisi {
	horizontal_kiri = 0
	horizontal_kanan
	horizontal_depan
	horizontal_belakang
	vertikal_atas
	vertikal_bawah	
	Null
}
enum pilih_team {
	A
	B
	C
	D
}
enum tipe_amunisi {
	HE_GRO_55
	HEAT
	PROX
	KINETIC
	PLASMA
	LASER
}
enum jenis_tombol_kontroler {
	maju
	mundur
	kiri
	kanan
	atas
	bawah
	menu
	isi_ulang
}
enum window_mode {
	full
	borderless
	window
}
const setingan : Dictionary = {
	"versi_data": 1.09,
	"suara_master" : 50,
	"suara_musik" : 50,
	"suara_emulator_tembakan" : 50,	
	"suara_roket":50,
	"resolusi": Vector2(1280,720) ,
	"window_mode": window_mode.borderless ,
	"debug":false,
	"mobile_controler": false,	
	"keyboard":true,
	"platform":"?",
	"cheat" : {
		"pelindung":false,
		"telekinesis":false,
		"penglihatan": false,
		"auto_play" : false,
		"aim_bot_100%": false,
		"aim_assis": false
	},
	"kontrol" : {
		"ui_maju":"w",
		"ui_mundur":"s",
		"ui_kanan":"a",
		"ui_kiri":"d",	
		"ui_rotasi_kanan":"e",
		"ui_rotasi_kiri":"q",
		"ui_atas":" ",
		"ui_bawah":"	",
		"isi_ulang":"r"
	}
}
var akun = {
	"nama" : ""
	,"pass" : ""
}
enum mode_tembak {
	semi = 0
	auto = 1
	trio = 2
	trip_stop = 4
}
const nama_file_akun : String = "user://akun.dat"
var amunisi_habis : String = "res://suara/OutOfAmmo_female(id).mp3"

func cek_data(seting_baru:Dictionary = setingan) -> Dictionary :
	var file : File = File.new()
	if file.open("user://setingan.dat",File.READ_WRITE) == OK :
		print("seting ditemukan")
		var set_data = file.get_var()
		#konvesi ke versi terbaru jika versi sudah tua
		if set_data.versi_data != setingan.versi_data :
			print("seting versi sudah lama")
			file.store_var(setingan)
			seting_baru = setingan
		else:
			seting_baru = set_data
		
	elif file.open("user://setingan.dat",File.WRITE) == OK:
		print("seting tidak ditemukan")
		if OS.has_feature("web") :
			seting_baru["platform"] = "web"
		elif OS.has_feature("x11") :
			seting_baru["platform"] = "x11"
		elif OS.has_feature("OSX") :
			seting_baru["platform"] = "OSX"
		elif OS.has_feature("Windows") :
			seting_baru["platform"] = "Windows"
		elif OS.has_feature("mobile") :
			seting_baru["platform"] = "mobile"
		file.store_var(seting_baru)
	file.close()
	return seting_baru
	
enum tipe_ruang {
	Pengunjung
	Server
	Master
	master_server
}

var tipe_lobi : int = tipe_ruang.master_server
var cheat_dibolehkan : bool = false
func _terapkan_pengaturan(_seting:Dictionary) -> void:
	
	OS.window_fullscreen = _seting["window_mode"] == window_mode.full or _seting["window_mode"] == window_mode.borderless
	OS.window_borderless = _seting["window_mode"] == window_mode.borderless
	
func _ubah_pengaturan(nama,nilai) -> void:
	var v = cek_data()
	v[nama] = nilai
	var file : File = File.new()
	if file.open("user://setingan.dat",File.WRITE) == OK :
		file.store_var(v)
	file.close()

func _ready() -> void:
	#_terapkan_pengaturan(cek_data())
	pass
