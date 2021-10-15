extends Node2D




func _ready():
	$Control/ButtonStart.grab_focus()

func _physics_process(delta):
	if $Control/ButtonStart.is_hovered() == true:
		$Control/ButtonStart.grab_focus()
	if $Control/ButtonExit.is_hovered() == true:
		$Control/ButtonExit.grab_focus()


func _on_ButtonStart_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_ButtonExit_pressed():
	get_tree().quit()


func _on_ButtonStory_pressed():
	get_tree().change_scene("res://Scenes/Story.tscn")
