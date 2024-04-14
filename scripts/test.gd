extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float) var speed
export(float) var max_walk_velocity
export(float) var roll_cooldown
export(float) var roll_inv_time
export(float) var roll_power
export(float) var pickup_range

export(float) var drag
var velocity = Vector2.ZERO
var itime = 0
var rollcd = 0
var can_pick_up
var points

onready var holder = get_node("Holding")

func vector_clamp(v, vmin, vmax):
	var x = clamp(v.x, vmin.x, vmax.x)
	var y = clamp(v.y, vmin.y, vmax.y)
	return Vector2(x, y)


# Called when the node enters the scene tree for the first time.
func _ready():
	start_level()
	pass # Replace with function body.
	
func start_level():
	velocity = Vector2.ZERO
	rollcd = 0.0
	itime = 0.0
	can_pick_up = get_tree().get_nodes_in_group("can_pick_up")
	points = get_tree().get_nodes_in_group("sacrificepoint")
	
func get_input():
	var direction = Vector2.ZERO
	
	direction = Input.get_vector("left_direction", "right_direction", "up_direction", "down_direction")
	
	return direction
	
func try_pick_up():
	
	can_pick_up = get_tree().get_nodes_in_group("can_pick_up")
	
	if holder.remote_path:
		var e = get_node(holder.remote_path)
		holder.remote_path = NodePath("")
		for p in points:
			if (e.position - p.position).length() < p.spike_distance:
				p.get_node("Spiked").remote_path = e.get_path()
				e.remove_from_group("can_pick_up")
		return
	
	if can_pick_up.empty():
		return
		
	var nearest = can_pick_up[0]
		
	for e in can_pick_up:
		if (position - e.position).length() < (position - nearest.position).length():
			nearest = e
			
	if (position - nearest.position).length() > pickup_range:
		holder.remote_path = nearest.get_path()
	
func get_itime():
	return itime
	
func process_roll(delta):
	itime -= delta
	
	if rollcd > 0:
		rollcd -= delta
		return
	
	if Input.is_action_just_pressed("action_one"):
		rollcd = roll_cooldown
		itime = roll_inv_time
		velocity *= roll_power
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_input()
	
	if Input.is_action_just_pressed("action_two"):
		try_pick_up()
	
	var acceleration = direction * delta * speed
	velocity += acceleration
	
	velocity -= velocity * delta * drag
	
	if velocity.length() > max_walk_velocity:
		velocity = velocity.normalized() * max_walk_velocity
		
	process_roll(delta)
		
	position += velocity * delta
	position = vector_clamp(position, Vector2(-1000,-500), Vector2(1000,500))
	
	
	
	
	
