extends Area2D

var damage = 10.0
var countered = false
var direction = Vector2(-775, 382).normalized()
var speed = 300.0

# Called when the node enters the scene tree for the first time.
func _ready():
    self.connect("body_entered", self, "on_body_entered")

func _physics_process(delta):
    position += direction * speed * delta

func counter(type):
    if (type == "redfireball"):
        countered = true
        explode()
        
func set_rotation(deg):
    $AnimatedSprite.rotation_degrees = deg

func explode():
    self.disconnect("body_entered", self, "on_body_entered")
    $AnimatedSprite.play("Explosion")
    $AnimationPlayer.play("ExplosionSize")
    yield($AnimatedSprite, "animation_finished")
    queue_free()

func on_body_entered(body):
    if (body.is_in_group("Player") and body.is_alive()):
            body.hit(damage)
            if (!body.is_alive()):
                speed = 0.0
            explode()   

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
