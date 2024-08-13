extends Control
class_name VictoryScreen

signal play_again

@onready var score_value = %ScoreValue

func set_score(value: int):
	score_value.text = str(value)

func _on_play_again_button_pressed():
	play_again.emit()

func _on_quit_button_pressed():
	Global.quit_game()

func _on_visible_on_screen_notifier_2d_screen_entered():
	%PlayAgainButton.grab_focus()
