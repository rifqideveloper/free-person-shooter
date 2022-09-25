extends CSGBox

signal kena_tembak(dmg)

export var darah : float = 4
export var jira : float = 2

func _ready():
	connect("kena_tembak",self,"kena_tembak")

func kena_tembak(dmg:float) -> void:
	darah -= dmg
	if darah <= 0.0 :
		queue_free()
