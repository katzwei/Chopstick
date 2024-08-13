extends Control
class_name Setting

signal go_back

@onready var master_bus_index: int = AudioServer.get_bus_index("Master")
@onready var music_bus_index: int = AudioServer.get_bus_index("Music")
@onready var sfx_bus_index: int = AudioServer.get_bus_index("SFX")

var master_volume_slider: HSlider
var music_volume_slider: HSlider
var sfx_volume_slider: HSlider

func _ready():
	master_volume_slider = %MasterVolumeSlider
	music_volume_slider = %MusicVolumeSlider
	sfx_volume_slider = %SFXVolumeSlider
	master_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_index)) * 100
	music_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index)) * 100
	sfx_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index)) * 100

func set_bus_volume(index: int, value: float) -> void:
	AudioServer.set_bus_volume_db(index, linear_to_db(value))

func _on_master_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(master_bus_index, value/100)

func _on_music_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(music_bus_index, value/100)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(sfx_bus_index, value/100)

func _on_crunch_sound_toggled(toggled_on):
	Global.crunch_sound_enabled = !toggled_on

func _on_fork_mode_toggled(toggled_on):
	Global.toggle_fork_mode(toggled_on)

func _on_back_button_pressed():
	go_back.emit()

func _on_quit_button_pressed():
	Global.quit_game()

func _on_visible_on_screen_notifier_2d_screen_entered():
	master_volume_slider.grab_focus()
