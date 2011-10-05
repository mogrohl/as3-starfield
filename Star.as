package
{
    import com.greensock.TweenNano;
    import com.greensock.easing.Linear;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.Stage;

    public class Star extends Sprite
    {
        [Embed(source="star.png")]
        private static const m_Image:Class;

        private var m_Bitmap:Bitmap;
        private var m_Stage:Stage;
        private var m_Init:Boolean;

        public function Star(
            l_Stage:Stage):void
        {
            m_Bitmap = new m_Image;
            m_Stage = l_Stage;
            m_Init = false;

            addChild(m_Bitmap);

            StartTween();
        }

        public function StartTween():void
        {
            m_Bitmap.width = (Math.random() * 15) + 1;
            m_Bitmap.height = m_Bitmap.width;
            m_Bitmap.x = -(Math.round(m_Bitmap.width / 2)); //object center
            m_Bitmap.y = m_Bitmap.x;

            x = m_Stage.stageWidth + width;
            y = Math.floor(Math.random() * m_Stage.stageHeight);

            TweenNano.to(this, (Math.random() * 8) + 2,
                {
                    x: -(uint(width / 2)),
                    rotation: (Math.random() * 2160) - 1080,
                    ease: Linear.easeIn,
                    onComplete: StartTween
                });
        }
    }
}