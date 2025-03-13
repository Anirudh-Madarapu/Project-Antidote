extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # You can initialize variables or set up things here if needed.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # You can add frame-by-frame logic here if needed.

# Function to zoom in
func zoom_in():
	zoom *= 0.9  # Reduce the zoom level by 10%

# Function to zoom out
func zoom_out():
	zoom *= 1.1  # Increase the zoom level by 10%

# Example of how to call the zoom functions based on input
