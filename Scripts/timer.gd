extends Control
class_name AutomatedTimer

signal stopped

@onready var label = $Label
@onready var timer = $Timer

var elapsed_time := 36000
var minutes := 0
var seconds := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()

func stop():
	timer.stop()
	stopped.emit()
	
func _on_timer_timeout():
	elapsed_time += 1
	if elapsed_time % 60 == 0:
		minutes += 1
		seconds = 0
	else:
		seconds += 1
	label.text = "%02d:%02d" % [minutes, seconds]
