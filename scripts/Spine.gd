extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = Vector2.LEFT
export(float) var speed = 300

func damage(area):
	var player = get_node("../..").get_node("%Player")
	if (area.get_parent() == player):
		player.damage(1)
		queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered", self, "damage")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	if (position.x > 1000 or position.x < -1000 or position.y > 500  or position.y < -500):
		queue_free()
