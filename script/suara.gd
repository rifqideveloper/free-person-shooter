extends Tabs

func _ready():
	pass


func _on_HSlider_value_changed_master(value):
	var _bus = AudioServer.get_bus_index("master")
	AudioServer.set_bus_volume_db(_bus, linear2db(value))

func _on_HSlider_value_changed_efek(value):
	var _bus = AudioServer.get_bus_index("efek")
	AudioServer.set_bus_volume_db(_bus, linear2db(value))

func _on_HSlider_value_changed_musik(value):
	var _bus = AudioServer.get_bus_index("musik")
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
