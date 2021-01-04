extends Area2D

var target
var speed = 300.0
var velocity = Vector2()
var direction = Vector2()
var exploded = false
var type = null
var damage = 10.0
var start_position = Vector2()

func _ready():
    self.connect("body_entered", self, "on_body_entered")
    self.connect("area_entered", self, "on_area_entered")

func _physics_process(delta):
    if (exploded):
        global_position = target.global_position
    else:
        if (start_position.distance_to(global_position) > 600):
            queue_free()
        else:
            velocity = direction * speed
            position += velocity * delta   
        
func set_position(pos):
    start_position = pos
    global_position = pos
    
func set_direction(dir):
    direction = dir
    
func set_target(tgt):
    target = tgt

func on_body_entered(body):
    if (body.is_in_group("Enemies")):
        if (body.is_alive()):
            body.hit(type, damage)
            set_target(body)
            explode()

func on_area_entered(area):
    if(area.is_in_group("BossSpells")):
        area.counter(type)
        set_target(area)
        explode()
            
func explode():
    exploded = true
    self.disconnect("body_entered", self, "on_body_entered")
    self.disconnect("area_entered", self, "on_area_entered")
    $AnimatedSprite.play("Explosion")
    $AnimationPlayer.play("ExplosionSize")
    yield($AnimatedSprite, "animation_finished")
    queue_free()
