extends Node2D

var direction = Vector2.LEFT
var acceleration = 300
var speed = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func damage(area):
	var player = get_node("../..").get_node("%Player")
	if (area.get_parent() == player):
		player.damage(1)
		queue_free()
		
func _process(delta):
	speed += acceleration * delta
	position += speed * direction * delta
	if (position.x > 1000 or position.x < -1000 or position.y > 500  or position.y < -500):
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("../..").get_node("%Player")
	$AnimationPlayer.play("Fireball_Start")
	$AnimationPlayer.queue("Fireball_Loop")
	$Area2D.connect("area_entered", self, "damage")
	direction = (player.position - position).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
