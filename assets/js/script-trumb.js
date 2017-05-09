$('#editor').trumbowyg({
    // btns: ['strong', 'em', '|', 'insertImage'],
    btns: [
        ['viewHTML'],
        ['formatting'],
        'btnGrp-semantic',
        ['superscript', 'subscript'],
        ['link'],'|',
        ['insertImage'],
        'btnGrp-justify',
        'btnGrp-lists',
        ['horizontalRule'],
        ['removeformat'],
        ['fullscreen'],
        'justifydrop',
        'listdrop'
    ],
    btnsDef: {
        justifydrop: {
            dropdown: ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
            ico: "justifyCenter"
        },
        listdrop: {
            dropdown: ['unorderedList', 'orderedList'],
            ico: "unorderedList"
        }
    },
    svgPath: '/css/icons.svg',//false
    semantic: true,//strong, em instead of b i
    resetCss: false,//reset css in editor,
    removeformatPasted: true,
    autogrow: false//adust to text size
});
