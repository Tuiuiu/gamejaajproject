extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var GRAVITY = 4000.0
var JUMP_FORCE = 1000.0
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _physics_process(delta):
    if (!is_on_floor()):
        velocity.y += GRAVITY * delta
    if (Input.is_action_just_pressed("ui_up") && is_on_floor()):
        velocity.y = -JUMP_FORCE
        
    move_and_slide(velocity, Vector2(0, -1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
