extends Node2D
var foi = false
var pode = false

func _ready():
    #Arrives and sighs
    $DialogBox.dialog = [["*sigh*", "protagonist"]]
    $DialogBox.visible = false
    $Node2D/CutscenePlayer.play("Run")
    $Node2D/AnimationPlayer.play("Arrive")
    yield($Node2D/AnimationPlayer,"animation_finished")
    $Node2D/CutscenePlayer.play("Idle")
    $DialogBox.load_dialog()
    $DialogBox.visible = true
    pode = true
    
    
func _process(_delta):
    if (Input.is_action_just_pressed("ui_accept") and !foi and pode):
        foi = true
        #Opens the door and enters the Tower
        $Node2D/CutscenePlayer.play("Attack1")
        yield($Node2D/CutscenePlayer, "animation_finished")
        $Node2D/CutscenePlayer.play("Idle")
        $AnimatedSprite.play("Open")
        yield($AnimatedSprite, "animation_finished")
        $Node2D/CutscenePlayer.play("Run")
        $Node2D/AnimationPlayer.play("Enter")
        yield($Node2D/AnimationPlayer, "animation_finished")
        $Node2D/CutscenePlayer.play("Idle")
        $Node2D/AnimationPlayer.play("Fade")
        #Camera starts moving upwards with narrative following
        $Camera2D/AnimationPlayer.play("Lift")
    
