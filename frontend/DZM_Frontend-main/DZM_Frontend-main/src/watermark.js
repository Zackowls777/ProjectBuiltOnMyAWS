

export function watermark(settings) {
    let defaultSettings={
        watermark_element: null,
        watermark_txt:["www.dachengoffer.com", "大 乘 Offer"],
        watermark_cord: [1, 3],
        watermark_id: ["website", "title"],
        watermark_x:20, //水印起始位置x轴坐标
        watermark_y:20, //水印起始位置Y轴坐标
        watermark_color:'#aaa', //水印字体颜色
        watermark_alpha:0.3, //水印透明度
        watermark_fontsize:'20px', //水印字体大小
        watermark_font:'微软雅黑', //水印字体
        watermark_width:300, //水印宽度
        watermark_height:200, //水印高度
        watermark_angle:30 //水印倾斜度数
    };
    //采用配置项替换默认值，作用类似jquery.extend
    if(arguments.length === 1 && typeof arguments[0] ==="object" )
    {
        let src=arguments[0]||{};
        for(let key in src)
        {
            if(src[key]&&defaultSettings[key]&&src[key]===defaultSettings[key])
                continue;
            else if(src[key])
                defaultSettings[key]=src[key];
        }
    }

    let oTemp = document.createDocumentFragment();
    const maskElement = defaultSettings.watermark_element;
    if(!maskElement) return;

    try {
        defaultSettings.watermark_id.forEach(function (id) {
            document.getElementById("mask_div" + id).remove();
        })
    }catch (e) {

    }

    //获取页面最大宽度、高度
    let page_width = maskElement.clientWidth, page_height = maskElement.clientHeight;

    defaultSettings.watermark_fontsize = (page_width / 40) + 'px';
    defaultSettings.watermark_width = page_width / 2;
    defaultSettings.watermark_height = page_height / 2;

    for(let index = 0; index < defaultSettings.watermark_id.length; index ++) {
        let width = defaultSettings.watermark_width, height = defaultSettings.watermark_height;
        let left = page_width / 4, top = page_height / 4;
        const delta = [[0, 0], [1, -1], [-1, -1], [-1, 1], [1, 1]];
        left += delta[defaultSettings.watermark_cord[index]][0] * page_width / 4;
        top += delta[defaultSettings.watermark_cord[index]][1] * page_height / 4;
        let mask_div = document.createElement('div');
        mask_div.className = 'mask-div';
        mask_div.id = 'mask_div' + defaultSettings.watermark_id[index];

        let mask_p = document.createElement('p');
        mask_p.innerHTML=(defaultSettings.watermark_txt[index]);
        mask_p.style.margin = "0px";
        mask_p.style.webkitTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
        mask_p.style.MozTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
        mask_p.style.msTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
        mask_p.style.OTransform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
        mask_p.style.transform = "rotate(-" + defaultSettings.watermark_angle + "deg)";
        mask_div.appendChild(mask_p);

        mask_div.style.visibility = "";
        mask_div.style.position = "absolute";
        mask_div.style.left = left + 'px';
        mask_div.style.top = top + 'px';
        mask_div.style.overflow = "hidden";
        mask_div.style.zIndex = "101";
        mask_div.style.pointerEvents='none';//pointer-events:none  让水印不遮挡页面的点击事件
        mask_div.style.filter="alpha(opacity=50)";
        mask_div.style.opacity = defaultSettings.watermark_alpha;
        mask_div.style.fontSize = defaultSettings.watermark_fontsize;
        mask_div.style.fontFamily = defaultSettings.watermark_font;
        mask_div.style.color = defaultSettings.watermark_color;
        mask_div.style.textAlign = "center";
        mask_div.style.width = width + 'px';
        mask_div.style.height = height + 'px';
        mask_div.style.display = "block";
        mask_div.style.lineHeight = defaultSettings.watermark_height + 'px';
        oTemp.appendChild(mask_div);
    }

    maskElement.appendChild(oTemp);
}

