extends KinematicBody2D

var MOVESPEED = 40
var active = true
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
    velocity.x += -MOVESPEED
    velocity.y = 0
    active = true

func _process_input(delta):
    if (active):
        move_and_slide(velocity, Vector2(0, -1))
