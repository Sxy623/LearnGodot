extends Node2D

var score = 0
var start_position = Vector2(960, 540)


func _ready():
	new_game()


func new_game():
	score = 0
	update_score()
	%GameOver.visible = false
	get_tree().paused = false
	%Player.health = 100.0
	%Player.global_position = start_position
	get_tree().call_group("mobs", "queue_free")


func spawn_mod():
	const MOB = preload("res://mob.tscn")
	var new_mob = MOB.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	new_mob.died.connect(_on_mob_died)


func update_score():
	%ScoreLabel.text = "Score: %d" % score


func _on_timer_timeout():
	spawn_mod()


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true


func _on_mob_died():
	score += 1
	update_score()
