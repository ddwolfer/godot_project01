extends Node2D

# var init
var isMove:bool = true
@export var moveSpeed:float = 100.0

# node
@onready var m_root = get_node(".")
@onready var m_bodyNode = get_node("Body")
@onready var m_bodyAni = get_node("Body/AnimatedSprite2D")

@onready var m_clothesTopNode = get_node("clothes/Top")
@onready var m_clothesTopAni = get_node("clothes/Top/AnimatedSprite2D")

enum DIRECT {
	left = 1 ,
	right = 2
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	PlayerMove(_delta)

func AllNodeSetDirect(direct):
	var scaleX = 1.0 if direct==DIRECT.right else -1.0

	m_bodyNode.scale = Vector2(scaleX ,1.0)
	m_clothesTopNode.scale = Vector2(scaleX ,1.0)

func PlayAllAni( aniName ):
	m_bodyAni.play(aniName)
	m_clothesTopAni.play(aniName)

func ResetAllAni():
	m_bodyAni.stop()
	m_bodyAni.frame = 0
	m_clothesTopAni.stop()
	m_clothesTopAni.frame = 0

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
		PlayAllAni(playAni)
		# 換方向
		if moveX > 0:
			AllNodeSetDirect(DIRECT.right)
			
		elif moveX < 0:
			AllNodeSetDirect(DIRECT.left)

		# 移動
		m_root.position.x = m_root.position.x + (moveX * moveSpeed * _delta)
		m_root.position.y = m_root.position.y + (moveY * moveSpeed * _delta)
	# 不動
	elif isMove:
		isMove = false
		ResetAllAni()
