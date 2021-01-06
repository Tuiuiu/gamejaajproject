extends Node2D


func _ready():
    $CanvasLayer/DialogBox.dialog = [["*sigh*", "protagonist"]]
    $CanvasLayer/DialogBox.visible = false
    $CanvasLayer/Node2D/CutscenePlayer.play("Run")
    $CanvasLayer/Node2D/AnimationPlayer.play("Arrive")
    yield($CanvasLayer/Node2D/AnimationPlayer,"animation_finished")
    $CanvasLayer/Node2D/CutscenePlayer.play("Idle")
    $CanvasLayer/DialogBox.load_dialog()
    $CanvasLayer/DialogBox.visible = true
    
func _process(delta):
    if Input.is_action_just_pressed("ui_accept"):
        $CanvasLayer/Node2D/CutscenePlayer.play("Attack1")
        yield($CanvasLayer/Node2D/CutscenePlayer, "animation_finished")
        $CanvasLayer/AnimatedSprite.play("Open")
        yield($CanvasLayer/AnimatedSprite, "animation_finished")
        $CanvasLayer/Node2D/CutscenePlayer.play("Run")
    
