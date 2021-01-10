extends Control

onready var player = $"BGM"
onready var animation = $"BGM/AnimationPlayer"

func _ready():
    animation.play("FadeIn")

func start_game():
    Global.goto_scene("res://Scenes/Cutscenes/CutsceneIntro.tscn")

func _on_CreditsButton_pressed():
    Global.goto_scene("res://Scenes/Credits/Credits.tscn")

func quit_game():
    get_tree().quit()

func _on_SoundIcon_toggled(button_pressed):
    if button_pressed:
        player.stop()
    else:
        player.play()
        animation.play("FadeIn")
