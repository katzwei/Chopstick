extends Node

signal sushi_left_screen
signal ate_sushi(value)
signal fork_mode(value)

var current_scene: Node = null
var crunch_sound_enabled := true
var fork_mode_enabled := false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()
	var scene = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = scene.instantiate()
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
func emit_sushi_left_screen():
	sushi_left_screen.emit()

func emit_ate_sushi(sushi_value):
	ate_sushi.emit(sushi_value)

func toggle_fork_mode(value: bool):
	fork_mode_enabled = value
	fork_mode.emit(value)

func quit_game():
	get_tree().quit()
