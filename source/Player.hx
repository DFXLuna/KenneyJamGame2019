import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.system.debug.interaction.tools.Pointer;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG.keys;
import flixel.addons.effects.FlxTrail;

class Player extends FlxSprite {
    public var m_speed: Float = 200;
    public var m_trail: FlxTrail;

    var m_movementFrameCounter: Int = 0;
    var m_angle: Float = 0;
    var m_up: Bool = false;
    var m_right: Bool = false;
    var m_down: Bool = false;
    var m_left: Bool = false;

    public function new(?x: Float = 0, ?y: Float) {
        super(x, y);
        makeGraphic(16, 16, FlxColor.WHITE);
        drag.x = 1000;
        drag.y = 1000;
        m_trail = new FlxTrail(this);
        solid = true;
    }

    override function update(elapsed:Float) {
        movement();
        super.update(elapsed);
    }

    function movement(){
        m_up = keys.anyPressed([UP]);
        m_right = keys.anyPressed([RIGHT]);
        m_down = keys.anyPressed([DOWN]);
        m_left = keys.anyPressed([LEFT]);
        if(!(m_up || m_down || m_left || m_right)){
            m_movementFrameCounter = 0;
            return;
        }
        if(m_up){
            m_angle = -90;
            if(m_right){
                m_angle += 45;
            }
            if(m_left){
                m_angle -= 45;
            }
        }
        else if(m_down){
            m_angle = 90;
            if(m_right){
                m_angle -= 45;
            }
            if(m_left){
                m_angle += 45;
            }
        }
        else if(m_right){
            m_angle = 0;
        }
        else if (m_left){
            m_angle = 180;
        }
        SetSpeed();
        velocity.set(m_speed, 0);
        velocity.rotate(FlxPoint.weak(0, 0), m_angle);
    }

    function SetSpeed()
    {
        if(m_movementFrameCounter < 16){ m_movementFrameCounter++; }
        m_speed = m_movementFrameCounter * m_movementFrameCounter;
    }
}