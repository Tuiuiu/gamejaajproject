extends KinematicBody2D

var MOVESPEED = 30.0
var active = true
var velocity = Vector2()
var state

func _ready():
    velocity.x += -MOVESPEED
    velocity.y = 60.0
    active = true
    change_state("run")
    $AnimatedSprite.flip_h = true

func _physics_process(delta):    
    if (active):
        move_and_slide(velocity, Vector2(0, -1))

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
    
func _process(delta):
    pass 

func change_state(new_state):
    if (state != new_state):
        match new_state:
            "run":
                $AnimatedSprite.play("Run")
            "hit":
                $AnimatedSprite.play("Hit")
            "attack":
                $AnimatedSprite.play("Attack")
            "death":
                $AnimatedSprite.play("Death")
        state = new_state


