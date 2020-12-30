extends KinematicBody2D

var MOVESPEED = 40.0
var velocity = Vector2()
var state
onready var active = true
onready var dead = false

func _ready():
    $VisibilityNotifier2D.connect("screen_exited", self, "clear")
    $AnimatedSprite.flip_h = true
    velocity.x += -MOVESPEED
    velocity.y = 60.0
    active = true
    change_state("run")

func _physics_process(delta):    
    if (active):
        move_and_slide(velocity, Vector2(0, -1))

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
                die()
        state = new_state

func hit(type):
    print("enemy")

func die():
    dead = true
    $AnimatedSprite.play("Death")
    yield($AnimatedSprite, "animation_finished")

func clear():
    queue_free()

func is_alive():
    return !dead
