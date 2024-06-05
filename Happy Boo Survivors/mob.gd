extends CharacterBody2D

signal died

var health = 3
var speed = 300.0
var min_distance = 80.0

@onready var player = get_node("/root/Game/Player")


func _ready():
	%Slime.play_walk()


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player > min_distance:
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		move_and_slide()


func take_damage():
	health -= 1
	%Slime.play_hurt()

	if health == 0:
		queue_free()
		died.emit()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
