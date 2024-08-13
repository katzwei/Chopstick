extends Control
class_name Credits

signal go_back

const SCROLL_SPEED := 100

@onready var scroll_container = %ScrollContainer

func _on_button_pressed():
	go_back.emit()

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		scroll_container.scroll_vertical -= roundi(SCROLL_SPEED * delta)
	if Input.is_action_pressed("ui_down"):
		scroll_container.scroll_vertical += roundi(SCROLL_SPEED * delta)

func _on_visible_on_screen_notifier_2d_screen_entered():
	%BackButton.grab_focus()
