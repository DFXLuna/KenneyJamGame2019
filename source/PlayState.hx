package;

import flixel.group.FlxGroup;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxCollision.createCameraWall;

class PlayState extends FlxState
{
    var m_player: Player;
    var m_outerBounds: FlxGroup;
    override public function create(): Void
    {
        super.create();
        FlxG.worldBounds.set(0,0, FlxG.width, FlxG.height);
        m_player = new Player(20, 20);
        add(m_player);
        add(m_player.m_trail);
        m_outerBounds = createCameraWall(camera, 20);
    }

    override public function update(elapsed: Float): Void
    {
        FlxG.collide(m_player, m_outerBounds);
        super.update(elapsed);
    }
}
