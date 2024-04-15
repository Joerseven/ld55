extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var frog = preload("res://creatures/Frog.tscn")
var rabbit = preload("res://creatures/Rabbit.tscn")
var duck = preload("res://creatures/Duck.tscn")
var hedgehog = preload("res://creatures/Hedgehog.tscn")

var levels = [["hedgehog", "rabbit", "frog", "duck"],["hedgehog", "rabbit", "frog", "duck"]]

var level_number = 0
var level_max = 1



var recipe_stack = levels[level_number]
var current_target

onready var rng = RandomNumberGenerator.new()
var dynamic_objects

func end_game():
	pass
	
func next_level():
	get_node("../UI").update_summoning_target("You win!")

func next_target():
	if recipe_stack.empty():
		if (level_number > level_max):
			end_game()
		else:
			next_level()
	else:
		current_target = recipe_stack.pop_back()
		get_node("../UI").update_summoning_target(current_target)
		
func on_player_death():
	get_node("../UI").update_summoning_target("Game Over!")

func start_level():
	for _i in range(10):
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
		
	next_target()
		
func on_creature_sacrificed(creature_type):
	if (creature_type == current_target):
		next_target()
	get_tree().call_group(creature_type, "aggro")
	
func init_sacrifice_listener():
	$Player.connect("creature_sacrificed", self, "on_creature_sacrificed")
	$Player.connect("player_death", self, "on_player_death")

func _ready():
	rng.randomize()
	start_level()
	init_sacrifice_listener()
	var static_objects = get_tree().get_nodes_in_group("fauna")
	for o in static_objects:
		var children = o.get_children()
		for c in children:
			c.z_index = c.position.y + c.texture.get_height() * 0.5 + 500



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dynamic_objects = get_tree().get_nodes_in_group("dynamic_z_index")
	for o in dynamic_objects:
		o.get_node("Sprite").z_index = o.position.y + 500
		
