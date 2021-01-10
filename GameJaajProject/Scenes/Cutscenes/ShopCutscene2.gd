extends Node2D


func _ready():
    $CanvasLayer/DialogBox.dialog = [["Hello", "???"],
    ["Eleanor!? How am I back at the shop!?", "Lumorith"],
    ["Ha ha ha ha! The name is Horace, friend, you took me for my downstairs colleague, Eleanor", "Horace"],
    ["Don't tell me you're THE Horace. The... 'Fang' of Justice", "Lumorith"],
    ["There is some irony to the title now, isn't it?", "Horace"],
    ["Yup", "Lumorith"],
    ["And your name would be...?", "Horace"],
    ["Oh, pardon me, the name is Lumorith. I've come to assure the current Watcher's safety", "Lumorith"],
    ["I'm afraid you might be late, friend. Monsters roam all over the Tower, and the Black Mage is nowhere to be found.", "Horace"],
    ["Then I must hurry! Tell me, Horace, is there anything I can take from your store?", "Lumorith"],
    ["There are some old scrolls who have no use for this old wolf, you can have them.", "Horace"],
    ["Thank you!","Lumorith"],
    ["Lumorith learned Hex!",""],
    ["Press R-H-E-X, G-H-E-X or B-H-E-X to cast a shield of the corresponding collor", ""],
    ["*Woof* (Remember to check your grimoire to learn about your new spells) *woof*", "Horace"]] 
    $CanvasLayer/DialogBox.load_dialog()
    yield($CanvasLayer/DialogBox, "end_of_dialog")
    Global.goto_scene("res://Scenes/World/World.tscn")



