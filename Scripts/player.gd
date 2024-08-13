extends Node2D
class_name Player

const AXIAL_SPEED := 240
const ROTATIONAL_SPEED := 50
const LEFT_CHOPSTICK = preload("res://Scenes/Ustensil/Chopstick/chopstick.tscn")
const RIGHT_CHOPSTICK = preload("res://Scenes/Ustensil/Chopstick/chopstick.tscn")
const FORK = preload("res://Scenes/Ustensil/Fork/fork.tscn")

@onready var ustensils_actions := [
	{
		"node": null,
		"x_actions": ["l_left", "l_right"],
		"y_actions": ["l_up", "l_down"],
		"r_actions": ["l_rotate_ccw", "l_rotate_cw"]
	},
	{
		"node": null,
		"x_actions": ["r_left", "r_right"],
		"y_actions": ["r_up", "r_down"],
		"r_actions": ["r_rotate_ccw", "r_rotate_cw"]
	},
]

var active_fork: Fork = null
var active_l_chopstick: Chopstick = null
var active_r_chopstick: Chopstick = null

func clean():
	if active_fork != null:
		active_fork.clean()

func remove_ustensil(node: Ustensil):
	ustensils_actions[0].node = null
	ustensils_actions[1].node = null
	node.queue_free()

func remove_fork():
	remove_ustensil(active_fork)
	active_fork = null

func remove_chopsticks():
	remove_ustensil(active_l_chopstick)
	remove_ustensil(active_r_chopstick)
	active_l_chopstick = null
	active_r_chopstick = null

func add_fork():
	active_fork = FORK.instantiate() as Fork
	add_child(active_fork)
	ustensils_actions[0].node = active_fork
	ustensils_actions[1].node = active_fork

func add_chopsticks():
	active_l_chopstick = LEFT_CHOPSTICK.instantiate() as Chopstick
	active_r_chopstick = RIGHT_CHOPSTICK.instantiate() as Chopstick
	active_l_chopstick.global_position.x -= 20
	active_r_chopstick.global_position.x += 20
	add_child(active_l_chopstick)
	add_child(active_r_chopstick)
	ustensils_actions[0].node = active_l_chopstick
	ustensils_actions[1].node = active_r_chopstick

func _ready():
	if Global.fork_mode_enabled:
		add_fork()
	else:
		add_chopsticks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for actions in ustensils_actions:
		var velocity = Vector2(
			Input.get_axis(actions.x_actions[0], actions.x_actions[1]),
			Input.get_axis(actions.y_actions[0], actions.y_actions[1])
		).normalized()
		var turn = Input.get_axis(actions.r_actions[0], actions.r_actions[1])
		if velocity != Vector2.ZERO:
			actions.node.move(velocity * AXIAL_SPEED * delta)
		if turn != 0.0:
			actions.node.turn(turn * ROTATIONAL_SPEED * delta)
