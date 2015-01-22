// coding: utf-8
// NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
// IT'S ALL JUST JUNK FOR OUR DOCS!
// ++++++++++++++++++++++++++++++++++++++++++

$('.carousel').carousel({
  interval: 3000 // in milliseconds
})

function tips_pop(){
      var MsgPop=document.getElementById("winpop");
        var popH=parseInt(MsgPop.style.height);//将对象的高度转化为数字
           if (popH==0){
                  MsgPop.style.display="block";//显示隐藏的窗口
                    show=setInterval("changeH('up')",2);
                       }
             else {
                    hide=setInterval("changeH('down')",2);
                      }
}
function changeH(str) {
     var MsgPop=document.getElementById("winpop");
      var popH=parseInt(MsgPop.style.height);
       if(str=="up"){
             if (popH<=100){
                   MsgPop.style.height=(popH+4).toString()+"px";
                     }
               else{
                     clearInterval(show);
                       }
                }
        if(str=="down"){
              if (popH>=4){
                    MsgPop.style.height=(popH-4).toString()+"px";
                      }
                else{
                      clearInterval(hide);
                        MsgPop.style.display="none";  //隐藏DIV
                          }
                 }
}
window.onload=function(){//加载
    document.getElementById('winpop').style.height='0px';
    setTimeout("tips_pop()",800);//3秒后调用tips_pop()这个函数
}
