extends KinematicBody2D

var GRAVITY = 50.0
var JUMP_FORCE = 650.0
var velocity = Vector2()
var jump_count = 0
var hp = 100

func _ready():
    pass

func _physics_process(delta):
    if (!is_on_floor()):
        velocity.y += GRAVITY# * delta
    if (is_on_floor()):
        velocity.y = 0
    if (Input.is_action_just_pressed("ui_up") && is_on_floor()):
        velocity.y = -JUMP_FORCE
        jump_count = 1
    if (Input.is_action_just_pressed("ui_up") && !is_on_floor()):
        if jump_count < 2:
            jump_count += 1
            velocity.y = -JUMP_FORCE + 70
        
    move_and_slide(velocity, Vector2(0, -1))

func _process(delta):
    
    if velocity.x == 0 && velocity.y == 0:
        $AnimatedSprite.animation = "Run"
    elif velocity.y < 0:
        $AnimatedSprite.animation = "Jump"
    elif velocity.y > 0:
        $AnimatedSprite.animation = "Fall"
