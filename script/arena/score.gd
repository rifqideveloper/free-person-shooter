extends Control
tool

export var score : Array = [0,0]
export var player_poin : Array = [[],[]]
func _ready():
	if Engine.editor_hint:
		for i in player_poin[0]:
			_tambah_player($VBoxContainer/label_team/team_A,["test_a","id",1,0,0,0,0,0])
		for i in player_poin[1]:
			_tambah_player($VBoxContainer/label_team/team_B,["test_b","sg",1,0,0,0,0,0])
	else :
		for i in player_poin[0]:
			_tambah_player($VBoxContainer/label_team/team_A,i)
		for i in player_poin[1]:
			_tambah_player($VBoxContainer/label_team/team_B,i)

func _update_score(score_baru:Array) -> void:
	 score = score
	
func _tambah_player(team:Node,info:Array) -> void:
	var l : Node = Label.new()
	l.text = info[0]
	team.get_node("nama_list").add_child( l )
	var lokasi : Node = Label.new()
	lokasi.align = Label.ALIGN_CENTER
	lokasi.text = info[1]
	team.get_node("lokasi_list").add_child(lokasi)
	var ping : Node = Label.new()
	ping.align = Label.ALIGN_CENTER
	ping.text = str(info[2])
	team.get_node("ping_list").add_child(ping)
	var poin : Node =  Label.new()
	poin.align = Label.ALIGN_CENTER
	poin.text = str(info[3])
	team.get_node("poin_list").add_child(poin)
	var bunuh : Node = Label.new()
	bunuh.align = Label.ALIGN_CENTER
	bunuh.text = str(info[4])
	team.get_node("bunuh_list").add_child(bunuh)
	var assis : Node = Label.new()
	assis.align = Label.ALIGN_CENTER
	assis.text = str(info[5])
	team.get_node("assis_list").add_child(assis)
	var score : Node = Label.new()
	score.align = Label.ALIGN_CENTER
	score.text = str(info[6])
	team.get_node("score_list").add_child(score)
	var posisi : Node = Label.new()
	posisi.align = Label.ALIGN_CENTER
	posisi.text = str(info[7])
	team.get_node("posisi_list").add_child(posisi)
	
	
func _kurang_player() -> void:
	pass



func _on_score_visibility_changed():
	if visible :
		$VBoxContainer/team/team_A_score.text = str(score[0]) 
		$VBoxContainer/team/team_B_score.text = str(score[0])
		for x in player_poin[0]:
			$VBoxContainer/label_team/team_A/nama_list.get_child(x+1).text = player_poin[0][x][0]
			$VBoxContainer/label_team/team_A/lokasi_list.get_child(x+1).text = player_poin[0][x][1]
			$VBoxContainer/label_team/team_A/ping_list.get_child(x+1).text = str(player_poin[0][x][2]) 
			$VBoxContainer/label_team/team_A/poin_list.get_child(x+1).text = str(player_poin[0][x][3])
			$VBoxContainer/label_team/team_A/bunuh_list.get_child(x+1).text = str(player_poin[0][x][4])
			$VBoxContainer/label_team/team_A/assis_list.get_child(x+1).text = str(player_poin[0][x][5])
			$VBoxContainer/label_team/team_A/score_list.get_child(x+1).text = str(player_poin[0][x][6])
			$VBoxContainer/label_team/team_A/posisi_list.get_child(x+1).text = str(player_poin[0][x][7])
		for x in player_poin[1]:
			$VBoxContainer/label_team/team_B/nama_list.get_child(x+1).text = player_poin[0][x][0]
			$VBoxContainer/label_team/team_B/lokasi_list.get_child(x+1).text = player_poin[0][x][1]
			$VBoxContainer/label_team/team_B/ping_list.get_child(x+1).text = str(player_poin[0][x][2]) 
			$VBoxContainer/label_team/team_B/poin_list.get_child(x+1).text = str(player_poin[0][x][3])
			$VBoxContainer/label_team/team_B/bunuh_list.get_child(x+1).text = str(player_poin[0][x][4])
			$VBoxContainer/label_team/team_B/assis_list.get_child(x+1).text = str(player_poin[0][x][5])
			$VBoxContainer/label_team/team_B/score_list.get_child(x+1).text = str(player_poin[0][x][6])
			$VBoxContainer/label_team/team_B/posisi_list.get_child(x+1).text = str(player_poin[0][x][7])
