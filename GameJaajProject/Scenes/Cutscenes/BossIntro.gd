extends Node2D
var foi = false
var pode = true

func _ready():
    $AudioStreamPlayer.play()
    $DialogBox.dialog=[["Brother!!", "Lumorith"],
    ["...","Black Mage"],
    ["Zahr, it's me! We must talk to the Circle, they think you've...", "Lumorith"],
    ]
    $DialogBox.visible = false
    $PlayerPosition/AnimationPlayer.play("Arrive")
    yield($PlayerPosition/AnimationPlayer, "animation_finished")
    $PlayerPosition/CutscenePlayer.play("Idle")
    $DialogBox.load_dialog()
    $DialogBox.visible = true

func _process(_delta):
    if ($DialogBox.speech == 3 and (Input.is_action_just_pressed("ui_accept")) and !foi and pode):
        fight_scene()


func fight_scene():
    foi = true
    $BlackMage.play("Attack1")
    yield($BlackMage, "animation_finished")
    $BlackMage.play("Idle")
    $PlayerPosition/CutscenePlayer.play("Hit")
    $PlayerPosition/AnimationPlayer.play("Fly")
    yield($PlayerPosition/AnimationPlayer, "animation_finished")
    $PlayerPosition/CutscenePlayer.play("Idle")
    $DialogBox.dialog = [["Zahr!?", "Lumorith"],
    ["*sigh* Oh, my brother, were they right all along?", "Lumorith"],
    ["I am... so sorry.", "Lumorith"]]
    $DialogBox.load_dialog()
    $DialogBox.visible = true
    final_fade()
    
func final_fade():
    yield($DialogBox, "end_of_dialog")
    $ColorRect/AnimationPlayer.play("Fade")
    yield($ColorRect/AnimationPlayer, "animation_finished")
    Global.goto_scene("res://Scenes/World/BossWorld.tscn")
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
