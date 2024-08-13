extends Node

@onready var menu = $Menu
@onready var setting = $Setting
@onready var credits = $Credits

func _on_menu_show_options():
	menu.visible = false
	setting.visible = true

func _on_setting_go_back():
	menu.visible = true
	setting.visible = false

func _on_menu_show_credits():
	menu.visible = false
	credits.visible = true

func _on_credits_go_back():
	menu.visible = true
	credits.visible = false
