extends KinematicBody2D

var MOVESPEED = 120.0
var active = true
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
    velocity.x += -MOVESPEED
    velocity.y = 60.0
    active = true

func _physics_process(delta):    
    if (get_global_position().x <= -100):
        die()
    if (active):
        move_and_slide(velocity, Vector2(0, -1))
    
func die():
    queue_free()
    
func _process(delta):
    if velocity.x != 0:
        $AnimatedSprite.animation = "Run"
        $AnimatedSprite.flip_h = true
