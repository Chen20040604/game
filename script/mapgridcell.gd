class_name MapGridCell

enum GridType {NONE,ROOM,N_WALL,L_WALL,R_WALL,S_WALL}

var pos : Vector2i 
var type : GridType = GridType.NONE
