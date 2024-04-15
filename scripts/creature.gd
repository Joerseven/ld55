extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var rng = RandomNumberGenerator.new()

var aggressive = false
var busy = false

var move_range = 250
var attack_range = 150
var move_speed = 100
var direction = Vector2.ZERO
var should_move = false
var attack_cooldown = 0
var picked_up = false

class Action:
	var should_finish = false
	var behaviour
	func process(_delta):
		print("DEATH TAKES THE PROGRAMMER")
		pass
		
class Movement:
	extends Action
	var target : Vector2
	func _init():
		target = Vector2.ZERO
		

var action

func start_idle():
	$AnimationPlayer.play("Idle")
	rng.randomize()
	$AnimationPlayer.advance(rng.randf())

# Called when the node enters the scene tree for the first time.
func _ready():
	level_start()

func level_start():
	
	picked_up = false
	aggressive = false
	direction = Vector2.ZERO
	busy = false
	attack_cooldown = 0
	
	rng.randomize()
	$Sprite.flip_h = rng.randi_range(0, 1)
	start_idle()
	
func aggro():
	aggressive = true

func find_space_to_move():
	pass
	
func attack():
	print("Should be overriden")
	
func move(delta):
	direction = (get_player().position - position).normalized()
	position += direction * move_speed * delta
	
func get_player():
	return get_parent().get_parent().get_node("Player")
	
	
func get_distance_from_player():
	var player_position = get_player().position
	return (position - player_position).length()

# This is gonna be hella messy
func get_next_move():
	if (picked_up):
		$AnimationPlayer.play("Idle")
		$AnimationPlayer.stop()
		return
		
	if busy:
		return
	# Reset defaults here
	busy = true
	should_move = false
	
	var player_distance = get_distance_from_player()
	
	if attack_cooldown <= 0:
		if (aggressive && player_distance < attack_range):
			direction = (get_player().position - position).normalized()
			attack()
			return
		elif (aggressive && player_distance < move_range):
			should_move = true
			$AnimationPlayer.play("Walk")
			busy = false
			return
		
	busy = false
	if $AnimationPlayer.current_animation == "Idle":
		return
	start_idle()
		
func update_behaviour():
	if rng.randi_range(1.0, 3.0) == 3:
		pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_next_move()
	if attack_cooldown > 0:
		attack_cooldown -= delta
	if should_move:
		move(delta)
		if (direction.x > 0):
			$Sprite.flip_h = true
		if (direction.x < 0):
			$Sprite.flip_h = false
#	if not action:
#		update_behaviour()
#	else:
#		action.process(delta)
#		if (action.should_finish):
#			action = null
		
		
