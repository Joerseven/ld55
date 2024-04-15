extends "res://scripts/creature.gd"

class_name Rabbit

var creature_type = "rabbit"
export(bool) var attacking
var earth_attack = preload("res://projectiles/RabbitAttack.tscn")

func attack():
	attacking = true
	$AnimationPlayer.play("Attack")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func spawn_rock():
	var player = get_node("../..").get_node("%Player")
	var instance = earth_attack.instance()
	instance.position = player.position + player.velocity * 0.35;
	get_node("../../Projectiles").add_child(instance)
	
	
func end_attack():
	attacking = false
	busy = false
	$AnimationPlayer.stop()
	attack_cooldown = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
