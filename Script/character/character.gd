extends Node2D

# var init
var isMove:bool = true
@export var moveSpeed:float = 100.0

# node
@onready var m_root = get_node(".")
@onready var m_bodyNode = get_node("Body")
@onready var m_bodyAni = get_node("Body/AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	PlayerMove(_delta)

func PlayerMove(_delta):
	print(_delta)
	# 角色移動
	var moveX = 0
	var moveY = 0
	var playAni = ""
	
	# 上下
	if Input.is_action_pressed("ui_down"):
		playAni = "move_down"
		moveY = moveY + 1
	if Input.is_action_pressed("ui_up"):
		playAni = "move_up"
		moveY = moveY - 1
		
	# 左右	
	if Input.is_action_pressed("ui_right"):
		playAni = "move_side"
		moveX = moveX + 1
	if Input.is_action_pressed("ui_left"):
		playAni = "move_side"
		moveX = moveX - 1
	
	# 動
	if moveX != 0 or moveY != 0:
		# 動畫更換
		isMove = true
		m_bodyAni.play(playAni)
		# 換方向
		if moveX > 0:
			m_bodyNode.scale = Vector2(1.0 ,1.0)
		elif moveX < 0:
			m_bodyNode.scale = Vector2(-1.0 ,1.0)
		# 移動
		m_root.position.x = m_root.position.x + (moveX * moveSpeed * _delta)
		m_root.position.y = m_root.position.y + (moveY * moveSpeed * _delta)
	# 不動
	elif isMove:
		isMove = false
		m_bodyAni.stop()
		m_bodyAni.frame = 0
