extends Control
class_name Menu

signal show_options
signal show_credits

func _ready():
	%PlayButton.grab_focus()

func _on_play_button_pressed():
	Global.goto_scene("res://Scenes/Game/game.tscn")
	
func _on_options_button_pressed():
	show_options.emit()
	
func _on_quit_button_pressed():
	Global.quit_game()
	
func _on_credits_button_pressed():
	show_credits.emit()

func _on_visible_on_screen_notifier_2d_screen_entered():
	%PlayButton.grab_focus()
