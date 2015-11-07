/*
* Win.js
* @version 0.1
* @author Jonatan Herran  || @jonatan2874
*/



// WIN.event = {
//     addListener: function(el, type, fn){
//         console.log(this)
//     },
//     removeListener: function(el, type, fn){
//     // código de relleno
//     },
//     getEvent: function(e) {
//     // código de relleno
//     }


//     // Puedes agregar otras propiedades y métodos
// }


Win = {
    windows:function (obj){

        // VAR PUBLIC
        var apply           = obj.apply || ''
        ,   bodyStyle       = obj.bodyStyle || ''
        ,   width           = obj.width || 200
        ,   height          = obj.height || 200
        ,   id              = obj.id || ''
        ,   title           = obj.title || ''
        ,   modal           = obj.modal || ''
        ,   autoScroll      = obj.autoScroll || ''
        ,   closable        = obj.closable || ''
        ,   autoDestroy     = obj.autoDestroy || ''
        ,   autoLoad        = obj.autoLoad || ''
        ,   drag            = obj.drag || ''
        ,   resize          = obj.resize || ''
        ,   theme           = obj.theme || ''
        ,   bodyColor       = obj.bodyColor || '#FFF'
        ,   backgroundTitle = obj.backgroundTitle || '#000'
        ,   body            = document.querySelector('body')
        ,   winModal        = document.createElement('div')
        ,   win             = this;

        // VAR CONSTRUCT
        var top
        ,   left;

        winModal.setAttribute('id','Win_'+id);
        winModal.setAttribute('class','winModal');


        this.draggMove = function(idMove,xpos,ypos){
            idMove.style.left = xpos + 'px';
            idMove.style.top = ypos + 'px';
        },
        this.draggStart = function(idMove,divContainer,evt){
            idMove=document.getElementById(idMove);

            var evt     = evt || window.event
            ,   posX    = evt.clientX
            ,   posY    = evt.clientY
            ,   divTop  = (idMove.style.top).replace('px','')
            ,   divLeft = (idMove.style.left).replace('px','')
            ,   eWi     = parseInt(idMove.offsetWidth)
            ,   eHe     = parseInt(idMove.offsetHeight)
            ,   cWi     = parseInt(divContainer.offsetWidth)
            ,   cHe     = parseInt(divContainer.offsetHeight);

            divContainer.style.cursor='move';
            var diffX = posX - divLeft
            ,   diffY = posY - divTop;

            document.onmousemove = function(evt){
                evt = evt || window.event;
                var posX = evt.clientX
                ,   posY = evt.clientY
                ,   aX   = posX - diffX
                ,   aY   = posY - diffY;

                if (aX < 0) aX = 0;
                if (aY < 0) aY = 0;
                if (aX + eWi > cWi) aX = cWi - eWi;
                if (aY + eHe > cHe) aY = cHe -eHe;
                win.draggMove(idMove,aX,aY);
            }
        },
        this.draggStop = function(divContainer){
            divContainer.style.cursor='default';
            document.onmousemove = function(){}
        },
        this.show = function(){

            document.getElementById(apply).onclick=function(){

                var tbar = '';
                if(typeof(obj.tbar) == 'object'){
                    tbar += '<div class="win_tbar" id="win_tbar_"'+id+'>';

                    (obj.tbar).forEach(function(value,index,element){
                        if (value.xtype == 'button') { tbar += Win.button(value).value; };
                        if (value.xtype == 'button') { tbar += Win.button(value).value; };

                        // console.log(value+'-'+index);
                    });
                    tbar += '</div>';

                }

                left = (body.offsetWidth < width)? width: (body.offsetWidth - width)/2;
                top  = (body.offsetHeight < height)? height: (body.offsetHeight - height)/2;

                winModal.innerHTML = '<div style="width:'+width+';height:'+height+'; top:'+top+'; left:'+left+'; background-color:'+bodyColor+'; '+bodyStyle+'" id="'+id+'">'
                                        +'<div class="win_title" id="win_title_'+id+'" style="background-color:'+backgroundTitle+';">'
                                            +'<div class="win_title_txt">'+title+'</div>'
                                            +'<div class="win_title_btn" id="btn_close_ventana_'+id+'">x</div>'
                                        +'</div>'
                                        +tbar
                                        +'<div class="win_div_parent_body">Contenido</div>'
                                        +'<div class="win_div_resize" id="win_div_resize_'+id+'"></div>'
                                    +'</div><script onload>alert(1);</script>';
                body.appendChild(winModal);


                document.querySelector('#btn_close_ventana_'+id).onclick = function(){ win.close(); }
                document.querySelector('#win_title_'+id).onmousedown = function(){ win.draggStart(id,winModal,event); };
                document.querySelector('#win_title_'+id).onmouseup   = function(){ win.draggStop(winModal); };

                // myResize('win_div_resize_'+id);
            }
        }(),
        this.close = function(){ body.removeChild(winModal); }

    },
    tbar:function(obj){
        if(typeof(obj) == 'object'){ console.log(2); }
            else{ console.log(1); }
    },
    button:function(obj){
        this.value = '<button class="win_btn">Guardar<br>prueba</button>';
    },
    buttongroup:function(){

    }
}

// Win.prototype.close = function() {
//     this.body.removeChild(this.winModal);
// };


myResize = function  (elementId) {
    var r = document.getElementById(elementId); // element to make resizable
    var p = r.parentNode;

    r.addEventListener('mousedown', initDrag, false);
    var startX, startY, startWidth, startHeight;

    function initDrag(e) {
       startX = e.clientX;
       startY = e.clientY;
       startWidth = parseInt(document.defaultView.getComputedStyle(p).width, 10);
       startHeight = parseInt(document.defaultView.getComputedStyle(p).height, 10);
       document.documentElement.addEventListener('mousemove', doDrag, false);
       document.documentElement.addEventListener('mouseup', stopDrag, false);
    }

    function doDrag(e) {
        if (e.clientX>=500) {
            p.style.width = (startWidth + e.clientX - startX) + 'px';
            p.style.width = (startWidth + e.clientX - startX) + 'px';
        }

        if (e.clientY>=340) {
            p.style.height = (startHeight + e.clientY - startY) + 'px';
            p.style.height = (startHeight + e.clientY - startY) + 'px';
        }
    }

    function stopDrag(e) {
        document.documentElement.removeEventListener('mousemove', doDrag, false);
        document.documentElement.removeEventListener('mouseup', stopDrag, false);
    }

}


