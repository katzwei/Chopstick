extends Node2D
class_name Mouth

@onready var mouth_closed = $MouthClosed
@onready var mouth_open = $MouthOpen
@onready var center = $Center

#signal eating(value: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	close()

func open():
	mouth_closed.visible = false
	mouth_open.visible = true	

func close():
	mouth_closed.visible = true
	mouth_open.visible = false

func _on_proximity_area_body_entered(body):
	if body is Sushi:
		open()

func _on_proximity_area_body_exited(body):
	if body is Sushi:
		close()

func _on_eat_area_body_entered(body):
	# redundant check is required in order to avoid eating anything other than a suhsi object
	if body is Sushi:
		var sushi: Sushi = body
		sushi.position = center.global_position
		sushi.eat()
		#print_debug("sushi animation eating")
		#eating.emit(sushi.value)

