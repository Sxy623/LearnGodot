extends CharacterBody2D

signal health_depleted

var health = 100.0


func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	var activity_area = Rect2(Vector2(-500, -500), Vector2(2920, 2080))
	if global_position.x < activity_area.position.x:
		global_position.x = activity_area.position.x
	elif global_position.x > activity_area.position.x + activity_area.size.x:
		global_position.x = activity_area.position.x + activity_area.size.x

	if global_position.y < activity_area.position.y:
		global_position.y = activity_area.position.y
	elif global_position.y > activity_area.position.y + activity_area.size.y:
		global_position.y = activity_area.position.y + activity_area.size.y
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()

	const DAMAGE_RATE = 20.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
