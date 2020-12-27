extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var GRAVITY = 50.0
var JUMP_FORCE = 650.0
var velocity = Vector2()
var jump_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _physics_process(delta):
    if (!is_on_floor()):
        velocity.y += GRAVITY# * delta
    if (Input.is_action_just_pressed("ui_up") && is_on_floor()):
        velocity.y = -JUMP_FORCE
        jump_count = 1
    if (Input.is_action_just_pressed("ui_up") && !is_on_floor()):
        if jump_count < 2:
            jump_count += 1
            velocity.y = -JUMP_FORCE + 70
        
    move_and_slide(velocity, Vector2(0, -1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
