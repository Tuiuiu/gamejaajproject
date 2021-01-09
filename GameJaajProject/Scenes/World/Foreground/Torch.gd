extends PathFollow2D

var originalScale = Vector2()
var originalLightScale
var speed = 40.0
# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play("Torchlight")
    originalScale = $AnimatedSprite.scale
    originalLightScale = $Light2D.texture_scale
    self.loop = false

func _physics_process(delta):
    offset += speed * delta
    if (unit_offset == 1):
        queue_free()
    var sizeModifier = 1 - abs(-0.5 + unit_offset)
    #print(sizeModifier)
    $AnimatedSprite.scale = (originalScale * sizeModifier)
    $Light2D.texture_scale = (originalLightScale * sizeModifier)
    #print($AnimatedSprite.scale)

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

func stop_motion():
    speed = 0.0
    
func resume_motion():
    speed = 40.0
