extends "res://scripts/creature.gd"

class_name Hedgehog

var offset = 0
var attacking = false
var attack_timer = 0.5

export(int) var spine_count

var spine = preload("res://projectiles/Spine.tscn")

var creature_type = "hedgehog"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func attack():
	if (attacking == false):
		$AnimationPlayer.play("Attack")
		$AnimationPlayer.queue("Attack_Loop")
		attacking = true
	
func spawn_quills():
	var projectiles = get_node("../../Projectiles")
	for i in range(spine_count):
		var instance = spine.instance()
		instance.position = position + Vector2(0, -35)
		instance.direction = instance.direction.rotated(deg2rad((i / float(spine_count) * 360) + offset))
		instance.rotation_degrees = (i / float(spine_count) * 360) + offset
		projectiles.add_child(instance)
	offset += 360 / float(spine_count) * 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (attacking == true):
		attack_timer -= delta
		if (attack_timer <= 0):
			attacking = false
			busy = false
			attack_timer = 0.5
