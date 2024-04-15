extends "res://scripts/creature.gd"

class_name Duck

var creature_type = "duck"

var fireball = preload("res://projectiles/Fireball.tscn")

func attack():
	$AnimationPlayer.play("Attack")
	
func spawn_fireball():
	var projectiles = get_node("../../Projectiles")
	var instance = fireball.instance()
	instance.position = position + Vector2(-15 + 30 * int($Sprite.flip_h), -41)
	projectiles.add_child(instance)
	
func end_attack():
	busy = false
	$AnimationPlayer.stop()
	attack_cooldown = 2.0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
