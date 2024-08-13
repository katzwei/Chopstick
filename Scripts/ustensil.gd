extends CharacterBody2D
class_name Ustensil

const FORCE := 125

func move(vector: Vector2):
	var collision = move_and_collide(vector)
	if collision != null:
		var body = collision.get_collider()
		if body is Sushi:
			body.apply_central_force(collision.get_normal() * -FORCE)
	
func turn(degree: float):
	rotate(deg_to_rad(degree))
