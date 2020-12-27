extends KinematicBody2D

var GRAVITY = 50.0
var JUMP_FORCE = 650.0
var velocity = Vector2()
var jump_count = 0
var state
var castSpells
var availableSpells
onready var hp = 100

func _ready():
    castSpells = $Spells
    change_state("run")

func _physics_process(delta):
    if (!is_on_floor()):
        velocity.y += GRAVITY
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
    if hp <= 0:
        hide()
    if velocity.y < 0:
        change_state("jump")
        yield($AnimatedSprite, "animation_finished")
        change_state("run")
    elif velocity.y > 0:
        change_state("fall")
        yield($AnimatedSprite, "animation_finished")
        change_state("run")

func change_state(new_state):
    if (state != new_state):
        match new_state:
            "run":
                $AnimatedSprite.play("Run")
            "hit":
                $AnimatedSprite.play("Hit")
            "attack1":
                $AnimatedSprite.play("Attack 1")
            "attack2":
                $AnimatedSprite.play("Attack 2")
            "death":
                $AnimatedSprite.play("Death")
            "fall":
                $AnimatedSprite.play("Fall") 
            "jump":
                $AnimatedSprite.play("Jump")
            "idle":
                $AnimatedSprite.play("idle")
        state = new_state

func hit(damage):
    hp = hp - damage
    if (hp > 0):
        change_state("hit")
        $AnimationPlayer.play("DamageEffect")
        yield($AnimatedSprite, "animation_finished")
        change_state("run")
    elif (hp <= 0):
        die()
        
func die():
    change_state("death")
    yield($AnimatedSprite, "animation_finished")
    queue_free()
