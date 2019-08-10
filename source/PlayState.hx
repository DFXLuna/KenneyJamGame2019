package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxG.keys;
import flixel.util.FlxCollision;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState
{
    var m_player: Player;
    var m_background: FlxSprite;
    var m_maxY: Float;
    var m_cameraWalls: FlxGroup;

    function SetupCamera(maxY: Float): Void
    {
        FlxG.camera.follow(m_player, FlxCameraFollowStyle.PLATFORMER);
        FlxG.camera.setScrollBounds(0, null, 0, maxY);
    }

    function SetupBackdrop(): Void
    {
        m_background = new FlxBackdrop("assets/images/backdrops/backgroundEmpty.png", 1, 1, true, false);
        m_maxY = m_background.height;
        add(m_background);
    }

    function ProcessCollisions(): Void
    {
        if(m_player.x < 0)
        {
            m_player.x = 0;
        }
        if(m_player.y > m_maxY - m_player.height)
        {
            m_player.y = m_maxY - m_player.height;
        }
        else if(m_player.y < 0)
        {
            m_player.y = 0;
        }
    }

    function ProcessInput(): Void
    {
        if(keys.justPressed.ESCAPE)
        {
            openSubState(new PauseSubstate());
        }
    }

    override public function create(): Void
    {
        super.create();
        m_player = new Player(20, 20);
        SetupBackdrop();
        SetupCamera(m_maxY);
        add(m_player);
        add(m_player.m_trail);
    }

    override public function update(elapsed: Float): Void
    {
        ProcessCollisions();
        ProcessInput();
        super.update(elapsed);
    }
}
