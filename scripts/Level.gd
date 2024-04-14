extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var frog = preload("res://creatures/Frog.tscn")
var rabbit = preload("res://creatures/Rabbit.tscn")
var duck = preload("res://creatures/Duck.tscn")
var hedgehog = preload("res://creatures/Hedgehog.tscn")

onready var rng = RandomNumberGenerator.new()

func start_level():
	for i in range(10):
		var instance = frog.instance()
		instance.position = Vector2(rng.randf_range(-950, 950), rng.randf_range(-450, 500))
		$Creatures.add_child(instance) 
		
		instance = rabbit.instance()
		instance.position = Vector2(rng.randf_range(-950, 950), rng.randf_range(-450, 500))
		$Creatures.add_child(instance) 
		
		instance = hedgehog.instance()
		instance.position = Vector2(rng.randf_range(-950, 950), rng.randf_range(-450, 500))
		$Creatures.add_child(instance) 
		
		instance = duck.instance()
		instance.position = Vector2(rng.randf_range(-950, 950), rng.randf_range(-450, 500))
		$Creatures.add_child(instance) 

func _ready():
	rng.randomize()
	start_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
