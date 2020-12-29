extends Area2D

var target
var speed = 150.0
var velocity = Vector2()
var direction = Vector2()
var exploded = false
var type = null

func _ready():
    self.connect("body_entered", self, "on_body_entered")

func _physics_process(delta):
    if (target != null):
        if (exploded):
            global_position = target.global_position
        else:
            direction = (target.global_position - global_position).normalized()
            velocity = direction * speed
            position += velocity * delta
    else: # If the target ceases to exist
        queue_free()

func set_position(pos):
    global_position = pos
    
func set_target(tgt):
    target = tgt

func on_body_entered(body):
    if (body.is_in_group("Enemies")):
        exploded = true
        body.hit(type)
        $AnimatedSprite.play("Explosion")
        $AnimationPlayer.play("ExplosionSize")
        yield($AnimatedSprite, "animation_finished")
        queue_free()
