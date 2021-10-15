extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 200
const GRAVITY = 20
const JUMP_HEIGHT = -500

const FIREBALL = preload("res://Fireball.tscn")

var motion = Vector2() # moving in 2d space
var is_attacking = false
var is_dead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if is_dead == false:
	
	
		motion.y += GRAVITY
		
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false || is_on_floor() == false:
				motion.x = SPEED
				if is_attacking == false:
					$Sprite.flip_h = false #flip sprite to face direction
					$Sprite.play("Run")
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false || is_on_floor() == false:
				motion.x = -SPEED
				if is_attacking == false:
					$Sprite.flip_h = true #flip sprite to face direction
					$Sprite.play("Run")
					if sign($Position2D.position.x) == 1:
						$Position2D.position.x *= -1
		else:
			motion.x = 0
			if is_attacking == false:
				$Sprite.play("Idle")
		
		
		if Input.is_action_just_pressed("ui_focus_next") && is_attacking == false:
			if is_on_floor():
				motion.x = 0
			is_attacking = true
			$Sprite.play("Attack")
			var fireball = FIREBALL.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			
		
		
		if is_on_floor():
			if Input.is_action_pressed("ui_up"):
				$SoundJump.play()
				if is_attacking == false:
					motion.y = JUMP_HEIGHT
		else:
			if is_attacking == false:
				if motion.y < 0:
					$Sprite.play("Jump")
					
				else:
					$Sprite.play("Fall")
		# use move_and_slide to create movement on screen
		motion = move_and_slide(motion, UP)
		
		pass
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()

func dead():
	is_dead = true
	motion = Vector2(0, 0)
	$Sprite.play("Die")
	$SoundDie.play()
	$CollisionShape2D.disabled = true
	$Timer.start()


func _on_Sprite_animation_finished():
	is_attacking = false


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/GameOverScreen.tscn")


