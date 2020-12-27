extends KinematicBody2D

var MOVESPEED = 30.0
var active = true
var velocity = Vector2()
var state = "running"

# Called when the node enters the scene tree for the first time.
func _ready():
    velocity.x += -MOVESPEED
    velocity.y = 60.0
    active = true
    change_state("running")
    $AnimatedSprite.flip_h = true

func _physics_process(delta):    
    if (active):
        move_and_slide(velocity, Vector2(0, -1))

func _on_VisibilityNotifier2D_screen_exited():
    print("saiu")
    queue_free()
    
func _process(delta):
    pass 

func change_state(new_state):
    if (state != new_state):
        match new_state:
            "running":
                $AnimatedSprite.play("Run")
            "damage":
                $AnimatedSprite.play("Hit")
            "attack":
                $AnimatedSprite.play("Attack")
            "death":
                $AnimatedSprite.play("Death")
        state = new_state


