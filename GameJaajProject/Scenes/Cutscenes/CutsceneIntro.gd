extends Node2D
var foi = false
var pode = false

func _ready():
    #Arrives and sighs
    $CanvasLayer/DialogBox.dialog = [["*sigh*", "protagonist"]]
    $CanvasLayer/DialogBox.visible = false
    $Node2D/CutscenePlayer.play("Run")
    $Node2D/AnimationPlayer.play("Arrive")
    yield($Node2D/AnimationPlayer,"animation_finished")
    $Node2D/CutscenePlayer.play("Idle")
    $CanvasLayer/DialogBox.load_dialog()
    $CanvasLayer/DialogBox.visible = true
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
        $CanvasLayer/DialogBox.dialog = [["The Far Mountain's Watchtower was created to seal Tharnax, a great evil that once brought despair to our world."," "],
        ["Every generation, a mage is choosen to be the Tower's Watcher."," "],
        ["When his brother, the Red Mage choosen as Watcher, was said to be gone mad by the tower's curse, Lumorith was summoned.", " "],
        ["To investigate, and, if needed, take his place as The Watcher."," "],
        ["The Circle of Magi wondered if it was too late to stop the return of Tharnax"," "],
        ["Lumorith rushed in wishing it wasn't too late to save his brother, Zahr", " "],
        ["Heavens, how wrong were they...", " "]]
        $CanvasLayer/DialogBox.load_dialog()
        $CanvasLayer/DialogBox.visible = true
        yield($Camera2D/AnimationPlayer, "animation_finished")
        final_fade()
    
func final_fade():
    $ColorRect/AnimationPlayer.play("Fade")
    yield($ColorRect/AnimationPlayer, "animation_finished")
    Global.goto_scene("res://Scenes/World/World.tscn")
