extends KinematicBody2D

signal health_changed(health)
signal player_died
signal spell_cast(id, cd)

var GRAVITY = 50.0
var JUMP_FORCE = 650.0
var velocity = Vector2()
var jump_count = 0
var state
var castSpells
var availableSpells = []
var cooldownHandler
var cooldowns = {
	0: false,
	1: false,
	2: false,
	3: false
}
var MAX_HP = 100
var world
var camera
onready var dead = false
onready var hp = 10

func _ready():
	availableSpells.append(load("res://Scenes/Spells/Fireballs/Red_fireball.tscn"))
	availableSpells.append(load("res://Scenes/Spells/Fireballs/Black_fireball.tscn"))
	availableSpells.append(load("res://Scenes/Spells/Fireballs/Green_fireball.tscn"))
	world = get_parent()
	castSpells = world.get_node("Spells")
	camera = world.get_node("Camera2D")
	change_state("run")
		
func _physics_process(delta):
	if (!is_on_floor()):
		velocity.y += GRAVITY
	if (is_on_floor()):
		velocity.y = 0
		if (state == "fall"):
			change_state("run")
	if (Input.is_action_just_pressed("ui_up")):
		if (!dead):
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
		pass
	elif (velocity.y > 0 && state == "jump"):
		change_state("fall")

func is_alive():
	return !dead
	
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
	if (!dead):
		hp -= damage
		emit_signal("health_changed", hp)
		if (hp > 0):
			change_state("hit")
			camera.shake(0.2, 15, 8)
			$AnimationPlayer.play("DamageEffect")
			yield($AnimatedSprite, "animation_finished")
			change_state("run")
		elif (hp <= 0):
			die()

func die():
	print("morreu")
	dead = true
	change_state("death")
	yield($AnimatedSprite, "animation_finished")
	$GenericTimer.wait_time = 3.0
	$GenericTimer.start()
	yield($GenericTimer, "timeout")
	emit_signal("player_died")

func get_target():
	if $RayCast2D.is_colliding():
		return $RayCast2D.get_collider()
	else:
		return null

func try_to_cast(index):
	# If player is alive
	if(is_alive()):
		# If skill is not on cooldown
		if (!cooldowns[index]):
			match index:
				0: # Red Fireball
					fireball_cast(0)
				1: # Black Fireball
					fireball_cast(1)  
				2: # Green Fireball
					fireball_cast(2)
				3: # Flashlight
					flashlight_cast()

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
		cooldowns[type] = true
		emit_signal("spell_cast", type, (type + 0.5))
			

func flashlight_cast():
	world.flashlight_spell()
	#cooldowns[3] = true

func sequence_pressed(action):
	$CastingAudioEffects.sequence_pressed(action)

func cooldown_over_handler(id):
	cooldowns[id] = false

