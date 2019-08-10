
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.FlxG.keys;

class PauseSubstate extends FlxSubState
{
    var m_btnResume: FlxButton;

    function clickResume(): Void
    {
        close();
    }

    public function new()
    {
        super(0x99808080);
        m_btnResume = new FlxButton(0, 0, "Resume", clickResume);
        m_btnResume.screenCenter();
        add(m_btnResume);
    }

    override function update(elapsed: Float) 
    {
        m_btnResume.update(elapsed);
        if(keys.justPressed.ESCAPE)
        {
            close();
        }
    }
}