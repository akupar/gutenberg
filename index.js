$(document).ready(function() {
    var currentPage = window.location.href.split("/").pop();

    var initialSortList = [];
    var sorters = {
        0: { sorter: false },
        1: { sorter: false },                
        4: { sorter: false },
        5: { sorter: false },                                
    };
    
    switch ( currentPage ) {
        case "index.html":
            initialSortList = [
                [1, -1]
            ];
            sorters[1] = "text";
            break;
        case "index-by-author.html":
            initialSortList = [
                [0, -1]
            ];
            sorters[0] = "text";
            break;
        case "index-by-lcsh.html":
            initialSortList = [
                [4, -1]
            ];
            sorters[4] = "text";
            break;
        case "index-by-lcc.html":
            initialSortList = [
                [5, -1]
            ];
            sorters[5] = "text";
            break;
    }
    
    $('table').tablesorter({
        dateFormat: "yyyy-mm-dd",

        usNumberFormat: false,


        ignoreCase: true,


        sortLocaleCompare: true,

        debug: false,

        headers: sorters,

        sortList: initialSortList,

    });

    if ( currentPage !== "index-by-author.html" ) {
        $('#col-author').on('click', function () {
            window.location = "index-by-author.html";
        });
    }
    if ( currentPage !== "index.html" ) {    
        $('#col-title').on('click', function () {
            window.location = "index.html";
        });
    }
    if ( currentPage !== "index-by-lcsh.html" ) {
        $('#col-lcsh').on('click', function () {
            window.location = "index-by-lcsh.html";
        });
    }
    if ( currentPage !== "index-by-lcc.html" ) {
        $('#col-lcc').on('click', function () {
            window.location = "index-by-lcc.html";
        });
    }
});

