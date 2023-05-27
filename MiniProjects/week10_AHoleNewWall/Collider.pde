class Collider {
  float x, y;
  float size;
  
  // Constructor
  Collider(float _size) {
    this.x = width/2;
    this.y = height/2;
    this.size = _size;
  }
  
  void moveCollider(float _x, float _y) {
    this.x =  _x;
    this.y = _y;
  }
    
  boolean checkCollision (Collider source) { // Check if user hit the target
    float dangerZone = (this.size + source.size)/2;
    if (abs(this.x - source.x) < dangerZone && abs(this.y - source.y) < dangerZone) {
      return true; // Collided
    }
    return false; // Not Collided
  }
}
