extends Node2D

var hit_player = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func damage_player(area):
	if hit_player: return
	var player = get_node("../..").get_node("%Player")
	if (area.get_parent() == player):
		player.damage(1)
		hit_player = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = false
	hit_player = false
	$AnimationPlayer.play("default")
	$Area2D.connect("area_entered", self, "damage_player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
