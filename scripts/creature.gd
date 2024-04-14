extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var rng = RandomNumberGenerator.new()

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

# Called when the node enters the scene tree for the first time.
func _ready():
	start_idle()

func find_space_to_move():
	pass
	
func update_behaviour():
	if rng.randi_range(1.0, 3.0) == 3:
		pass
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not action:
		update_behaviour()
	else:
		action.process(delta)
		if (action.should_finish):
			action = null
		
		
