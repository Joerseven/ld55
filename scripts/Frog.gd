extends "res://scripts/creature.gd"

class_name Frog

var creature_type = "frog"

func attack():
	$AnimationPlayer.play("Attack")
	
func burst():
	pass
	
	
func damage_player(area):
	var player = get_node("../..").get_node("%Player")
	if (area.get_parent() == player):
		player.damage(2)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


## Called when the node enters the scene tree for the first time.
func _ready():
	attack_range = 10
	$Area2D.connect("area_entered", self, "damage_player")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
