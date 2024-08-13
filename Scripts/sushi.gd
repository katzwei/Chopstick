extends RigidBody2D
class_name Sushi

@export var value := 0

@onready var animation_player = $AnimationPlayer
	
func eat():
	set_deferred("freeze", true)
	var eat_animation: Animation = animation_player.get_animation("eat")
	eat_animation.track_set_enabled(1, Global.crunch_sound_enabled)
	animation_player.play("eat")

func _on_visible_on_screen_notifier_2d_screen_exited():
	if !animation_player.is_playing():
		Global.emit_sushi_left_screen()
		queue_free()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "eat":
		Global.emit_ate_sushi(value)
