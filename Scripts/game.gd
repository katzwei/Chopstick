extends Node
class_name Game

@onready var player: Player = $Player
@onready var setting: Setting = $Setting
@onready var timer: AutomatedTimer = $Timer
@onready var score: Score = $Score
@onready var victory: VictoryScreen = $Victory
@onready var mouth: Mouth = $Mouth

var score_value := 0
var sushis_count := 23
var sushis_gone := 0

func end():
	player.set_process(false)
	timer.stop()
	victory.set_score(score_value)
	victory.visible = true

func add_to_score(value: int) -> void:
	score_value += value
	score.update_score(score_value)

func sushi_step() -> void:
	sushis_gone += 1
	if sushis_gone == sushis_count:
		end()

func dropped_sushi() -> void:
	add_to_score(-10)
	sushi_step()

func sushi_eaten(value: int) -> void:
	add_to_score(value)
	sushi_step()
	mouth.close()
	player.clean()

func switch_ustensil(value):
	if value:
		player.remove_chopsticks()
		player.add_fork()
	else:
		player.remove_fork()
		player.add_chopsticks()

func _ready() -> void:
	Global.sushi_left_screen.connect(dropped_sushi)
	Global.ate_sushi.connect(sushi_eaten)
	Global.fork_mode.connect(switch_ustensil)

func _input(event) -> void:
	if event.is_action_pressed("setting") && !victory.visible:
		setting.visible = !setting.visible

func _on_setting_go_back() -> void:
	setting.visible = !setting.visible

func _on_victory_play_again():
	get_tree().reload_current_scene()
