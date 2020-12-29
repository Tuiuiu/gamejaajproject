extends KinematicBody2D

var GRAVITY = 50.0
var JUMP_FORCE = 650.0
var velocity = Vector2()
var jump_count = 0
var state
var castSpells
var availableSpells = []
onready var hp = 100

func _ready():
    availableSpells.append(load("res://Scenes/Spells/Red_fireball.tscn"))
    availableSpells.append(load("res://Scenes/Spells/Black_fireball.tscn"))
    availableSpells.append(load("res://Scenes/Spells/Green_fireball.tscn"))
    castSpells = get_parent().get_node("Spells")
    change_state("run")
        
func _physics_process(delta):
    if (!is_on_floor()):
        velocity.y += GRAVITY
    if (is_on_floor()):
        velocity.y = 0
        if (state == "fall"):
            change_state("run")
    if (Input.is_action_just_pressed("ui_up")):
        if (is_on_floor()):
            velocity.y = -JUMP_FORCE
            jump_count = 1
            change_state("jump")
        elif (!is_on_floor()):
            if jump_count < 2:
                jump_count += 1
                velocity.y = -JUMP_FORCE + 70
                change_state("jump")
        
    move_and_slide(velocity, Vector2(0, -1))

func _process(delta):
    if hp <= 0:
        hide()
    elif (velocity.y > 0 && state == "jump"):
        change_state("fall")


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
    print("morreu")
    change_state("death")
    yield($AnimatedSprite, "animation_finished")
    queue_free()

func get_target():
    if $RayCast2D.is_colliding():
        return $RayCast2D.get_collider()
    else:
        return null

func try_to_cast(index):
    match index:
        1: # Red Fireball
            fireball_cast(0)
        2: # Black Fireball
            fireball_cast(1)  
        3: # Green Fireball
            fireball_cast(2)

func fireball_cast(type):
    var tgt = get_target()
    if (tgt == null):
        #NENHUM ALVO A VISTA
        pass
    else:
        var clone = availableSpells[type].instance()
        var src = $RayCast2D.position
        var dst = $RayCast2D.cast_to
        var dir = (dst - src).normalized()
        clone.set_direction(dir)
        clone.set_position(position)
        castSpells.add_child(clone) 
