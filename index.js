function localeCompareSupportsLocales() {
  try {
    'foo'.localeCompare('bar', 'i');
  } catch (e) {
    return e.name === 'RangeError';
  }
  return false;
}


$(document).ready(function() {
    var currentPage = window.location.href.split("/").pop();

    var initialSortList = [];
    var sorters = {
        0: { sorter: false },
        1: { sorter: false },                
        2: { sorter: false },
        3: { sorter: false },                                
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
                [2, -1]
            ];
            sorters[2] = "text";
            break;
        case "index-by-lcc.html":
            initialSortList = [
                [3, -1]
            ];
            sorters[3] = "text";
            break;
    }

   

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


    $('.author-tag').on('click', function() {
        window.location = "index-by-author.html#" + $(this).text();
    });
    $('.lcsh-tag').on('click', function() {
        window.location = "index-by-lcsh.html#" + $(this).text();
    });
    $('.lcc-tag').on('click', function() {
        window.location = "index-by-lcc.html#" + $(this).text();
    });
});

