extends Ustensil
class_name Fork

@onready var spike_joint = %SpikeJoint
@onready var left_spike = %LeftSpike
@onready var right_spike = %RightSpike
@onready var collision_spikes = %ForkSpikes/CollisionPolygon2D

var has_sushi := false

func clean():
	#print_debug("cleaned")
	has_sushi = false
	#collision_spikes.set_deferred("disabled", false)

func _process(delta):
	var vertical_movement = Input.get_axis("l_up", "l_down") != 0 || Input.get_axis("r_up", "r_down") != 0
	right_spike.disabled = vertical_movement || has_sushi
	left_spike.disabled = vertical_movement || has_sushi

func _on_fork_spikes_body_entered(body):
	if body is Sushi && !has_sushi:
		#body.set_deferred("freeze", true)
		body.set_deferred("lock_rotation", true)
		spike_joint.node_b = body.get_path()
		has_sushi = true
		#collision_spikes.set_deferred("disabled", true)
		#print_debug("sushi forked")
