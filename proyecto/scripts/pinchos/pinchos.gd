extends Area2D

# Velocidad de movimiento de los pinchos
const SMOOTH_SPEED = 200
# Segundos antes de volver los pinchos
const TIEMPO_ESPERA = 1.5
# Desplazamiento máximo de los pinchos
const DESP_MAX = 50
# Si los pinchos están orientados hacia la derecha (1) o izquierda (-1)
export var orientacion = 1
# Si los pinchos deben moverse
var mover_pinchos = false
# Cronómetro
var time_start = 0
var time_now = 0
# Posicion X maxima 
var pos_max = 0
# Posicion X actual
var pos_original = 0
# Si el movimiento es adelante o atras
var mov_adelante = 1
# Desplazamiento de los pinchos
var desp = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Posicion original y máxima
	pos_original = position.x
	pos_max = position.x + (DESP_MAX * orientacion)
	# Volteamos el sprite si la orientación es negativa
	if orientacion == -1:
		$Sprite.set_flip_h(true)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		sacar_pinchos()
	
	# Si hemos iniciado el cronometro
	if time_start != 0:
		# Tomamos el tiempo
		time_now = OS.get_unix_time()
		# Si han pasado 3 segundos
		if time_now > time_start + TIEMPO_ESPERA:
			# Restablecemos el cronómetro
			time_start = 0
			# Movemos los pinchos al revés
			mover_pinchos = true
			mov_adelante = -1
	# Si hay que mover los pinchos
	if mover_pinchos:
		# Desplazamiento depende de los frames
		desp = SMOOTH_SPEED * delta * orientacion * mov_adelante
		# Movemos los pinchos
		position.x += desp
		# Restringimos la posicion
		if orientacion == 1:
			position.x = clamp(position.x, pos_original, pos_max)
		else:
			position.x = clamp(position.x, pos_max, pos_original)
		# Si llega a la pos max
		if position.x == pos_max:
			# Iniciamos el cronometro
			time_start = OS.get_unix_time()
			# Dejamos de mover los pinchos
			mover_pinchos = false
		# Si vuelve a la pos original
		elif position.x == pos_original:
			# Restablecemos estado inicial
			mov_adelante = 1
			mover_pinchos = false	
	pass

# Activar los pinchos (moverlos)
func sacar_pinchos():
	mover_pinchos = true
