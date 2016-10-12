require('UIView,UIColor,NSString');
defineClass('ViewController', {
    fuckView: function() {
        var newstring = NSString.alloc().initWithFormat("%@%", "天通,粤贵,纸金,纸银,黄金,白银,美元,原油");
        var view = self.valueForKey("_fuckView");
        if (!view) {
            var arr = newstring.componentsSeparatedByString(",");
            view = UIView.alloc().init();
            view.setBackgroundColor(UIColor.blueColor());
            view.setFrame({x:20, y:20, width:100, height:100});
            console.log(arr);
        }
        return view;
    },
});