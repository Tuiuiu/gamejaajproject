extends Node2D
var animation = 0
onready var darkbell = preload ("res://Scenes/SpellAnimations/a_DarkBell.tscn")

func _ready():
    $DialogBox.dialog = [["...", "Lumorith"],
    ["Find peace, dear brother, for your watch is over.", "Lumorith"],
    ["I swear over my grimoire, no evil shall return to this land while I guard this Tower", "Lumorith"],
    ["Not even you *sigh*...", "Lumorith"]]
    
    death_dialog()

func death_dialog():
    $DialogBox.load_dialog()
    $FadeBlackMage/BlackMage.play("Death")


func _on_DialogBox_end_of_dialog():
    $DarkBell.visible = true
    $DarkBell.toll()    
    $DarkBell.global_translate(Vector2(600,400))
    $FadeBlackMage/AnimationPlayer.play("Fade")
    yield($FadeBlackMage/AnimationPlayer, "animation_finished")
    $AnimationPlayer.play("FinalFade")
    yield($AnimationPlayer, "animation_finished")
    #Ir pra cena dos créditos/ Thank You for Playing
    
    

    


