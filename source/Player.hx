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
    var m_rightPressed: Bool = false;
    var m_leftPressed: Bool = false;
    var m_leftReleased: Bool = false;
    var m_rightReleased: Bool = false;

    var m_direction: Int = 0;

    var m_jumpTime: Float = 0;
    var m_maxJumpTime: Float = 0.25;
    var m_jumpSpeed: Int = 250;
    public function new(?x: Float = 0, ?y: Float = 0) {
        super(x, y);
        makeGraphic(16, 16, FlxColor.BLACK);
        drag.x = 1000;
        drag.y = 1000;
        acceleration.y = 600;
        maxVelocity.set(m_speed, m_jumpSpeed);
        m_trail = new FlxTrail(this);
        solid = true;
    }

    override function update(elapsed:Float) {
        movement(elapsed);
        super.update(elapsed);
    }

    function movement(elapsed: Float){
        m_rightPressed = keys.anyPressed([RIGHT]);
        m_leftPressed = keys.anyPressed([LEFT]);
        m_rightReleased = keys.anyJustReleased([RIGHT]);
        m_leftReleased = keys.anyJustReleased([LEFT]);
        m_direction = 0;
        if(m_leftReleased || m_rightReleased){
            m_movementFrameCounter = 0;
            return;
        }

        if(m_rightPressed && !m_leftPressed)
        {
            m_direction = 1;
        }
        else if(m_leftPressed && !m_rightPressed)
        {
            m_direction = -1;
        }
        Jump(elapsed);
        SetSpeed();
        velocity.set(m_speed, velocity.y);
    }

    function Jump(elapsed: Float)
    {
        if(keys.anyJustPressed([SPACE]))
        {
            m_jumpTime = 0;
        }

        if(keys.anyPressed([SPACE]) && m_jumpTime >= 0)
        {
            m_jumpTime += elapsed;
            if(m_jumpTime > m_maxJumpTime)
            {
                m_jumpTime = -1;
            }
            else if(m_jumpTime > 0)
            {
                velocity.y = -0.6 * maxVelocity.y;
            }
        }
        else 
        {
            m_jumpTime = -1;
        }
    }

    function SetSpeed()
    {
        if(m_movementFrameCounter < 16){ m_movementFrameCounter++; }
        m_speed = m_movementFrameCounter * m_movementFrameCounter * m_direction;
    }
}