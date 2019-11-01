package ohgs;

import js.lib.intl.Collator.Collation;
import kha.math.Vector2;

import ohgs.Object;
import ohgs.tool.Direction;

class Entity extends Object{
    public var velocity:Vector2 = new Vector2();
    public var speed = 3.0;
    public var acceleration = 0.3;
    public var onGround = false;
    var collision:Int;
    public var platformer = false;

    public function new(x:Float, y:Float, ?width:Float, ?height:Float) {
        super(x,y,width,height);
    }

    override public function update() {
        super.update();

        position.x += velocity.x * speed;
        position.y += velocity.y * speed;
    }

    function collideRect(entity:Entity):Bool {
        checkRectCollision();
        var dx =(this.position.x + this.width/2 ) - (entity.position.x + entity.width/2);
        var dy =(this.position.y + this.height/2 ) - (entity.position.x + entity.height/2);


        var combined:Vector2 = new Vector2();
        combined.x = this.center.x + entity.center.x;
        combined.y = this.center.y + entity.center.y;

        if(Math.abs(dx) < combined.x){
            if(Math.abs(dy) < combined.y){
                var overlap:Vector2 = new Vector2();
                overlap.x = combined.x - Math.abs(dx);
                overlap.y = combined.y - Math.abs(dy);
                if(overlap.x >= overlap.y){
                    if(dy > 0){
                        this.collision = Direction.UP;
                        this.position.y += overlap.y;
                    }else{
                        this.collision = Direction.DOWN;
                        this.position.y -= overlap.y;
                    }
                }else{
                    if (dx > 0){
                        this.collision = Direction.LEFT;
                        this.position.x += overlap.x;
                    }else{
                        this.collision = Direction.RIGHT;
                        this.position.x -= overlap.x;
                    }
                }
            }else{
                this.collision = Direction.NONE;
            }
        }else{           
                this.collision = Direction.NONE;
        }
        return false;

    }


    function checkRectCollision() {
        if(collision == Direction.DOWN && velocity.y >= 0){
            onGround = true;
            velocity.y = 0;
        }else if (collision == Direction.UP && velocity.y <= 0){
            onGround = false;
            velocity.y = 0;
        }else if (collision == Direction.RIGHT && velocity.x >= 0){
            onGround = false;
            velocity.x = 0;
        }else if (collision == Direction.LEFT && velocity.x <= 0){
            onGround = false;
            velocity.x =0;
        }

        if (collision != Direction.DOWN && velocity.y > 0){
            onGround = false;
        }
    }
}