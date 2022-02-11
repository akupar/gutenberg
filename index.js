

function getTbody(htmlText) {
    var startTag = '<tbody>';
    var endTag = '</tbody>';
    var start = htmlText.indexOf(startTag);
    if ( start === -1 ) {
        return "";
    }
    var end = htmlText.indexOf(endTag, start + startTag.length);
    if ( end === -1 ) {
        return "";
    }

    return htmlText.substring(start + startTag.length, end + endTag.length);
}

function setSortedColumn(selector) {
    $('.header-sorted').addClass('header-unsorted');
    $('.header-sorted').removeClass('header-sorted');
    $(selector + "> span").addClass('header-sorted');
    $(selector + "> span").removeClass('header-unsorted');
}

var storage = {
    setItem: function(key ,val) {
        window.storage[key] = val;
    },
    getItem: function(key) {
        return window.storage[key];
    }
}

function timeout(cached) {
    var dfd = jQuery.Deferred();
    setTimeout(function() {
        dfd.resolve( cached );
    }, 100);

    return dfd.promise();
}

/**
 * Returns a promise of rows either from cache or downloads them.
 **/
function getRows(url, cacheId) {
    const cached = storage.getItem(cacheId);
    if ( cached ) {
        return timeout(cached);
    } else {
        return $.get( url )
                .then(function (data) {
                    return $(getTbody(data));
                });
    }
}

function loadState() {
    var queryParams = window.location.search.length > 0
                                                    ? window.location.search.substring(1).split('&')
                                                    : [];

    var hash = window.location.hash;

    console.log("load state");

    if ( queryParams.indexOf('by=author') !== -1 ) {
        getRows( 'index-by-author.html', 'by-author')
            .then(function(rows) {
                storage.setItem('by-author', rows);
                $( "tbody" ).html('').append( rows ).removeClass('faded');
                if ( hash ) {
                    window.location.hash = hash;
                }
                setClickHandlers();
                setSortedColumn('#col-author')
            });
    } else if ( queryParams.indexOf('by=lcsh') !== -1 ) {
        getRows( 'index-by-lcsh.html', 'by-lcsh')
            .then(function (rows) {
                storage.setItem('by-lcsh', rows);
                $( "tbody" ).html('').append( rows ).removeClass('faded');
                if ( hash ) {
                    window.location.hash = hash;
                }
                setClickHandlers();
                setSortedColumn('#col-lcsh')
            });
    } else if ( queryParams.indexOf('by=lcc') !== -1 ) {
        getRows( 'index-by-lcc.html', 'by-lcc')
            .then(function (rows) {
                storage.setItem('by-lcc', rows);
                $( "tbody" ).html('').append( rows ).removeClass('faded');
                if ( hash ) {
                    window.location.hash = hash;
                }
                setClickHandlers();
                setSortedColumn('#col-lcc')
            });
    } else if ( queryParams.length === 0 ) {
        getRows( 'index.html', 'by-title')
            .then(function (rows) {
                storage.setItem('by-title', rows);
                $( "tbody" ).html('').append( rows ).removeClass('faded');
                if ( hash ) {
                    window.location.hash = hash;
                }
                setClickHandlers();
                setSortedColumn('#col-title')
            });
    }
}

function setClickHandlers() {
    var queryParams = window.location.search.length > 0
                                                    ? window.location.search.substring(1).split('&')
                                                    : [];

    $('.author-tag').unbind('click').on('click', function() {
        $( "tbody" ).addClass('faded');
        var hash = $(this).text();
        history.pushState({ sortBy: 'author', hash: hash }, 'Tekijän mukaan', '?by=author#' + hash);
        loadState();
    });
    $('.lcsh-tag').unbind('click').on('click', function() {
        $( "tbody" ).addClass('faded');
        var hash = $(this).text();
        history.pushState({ sortBy: 'lcsh', hash: hash }, 'LCSH-luokan mukaan', '?by=lcsh#' + hash);
        loadState();
    });
    $('.lcc-tag').unbind('click').on('click', function() {
        $( "tbody" ).addClass('faded');
        var hash = $(this).text();
        history.pushState({ sortBy: 'lcc', hash: hash }, 'LCC-luokan mukaan', '?by=lcc#' + hash);
        loadState();
    });

    if ( queryParams.indexOf('by=author') === -1 ) {
        $('#col-author').unbind('click').on('click', function () {
            $( "tbody" ).addClass('faded');
            history.pushState({ sortBy: 'author' }, 'Tekijän mukaan', '?by=author');
            loadState();
        });
    }

    if ( queryParams.indexOf('by=lcsh') === -1 ) {
        $('#col-lcsh').unbind('click').on('click', function () {
            $( "tbody" ).addClass('faded');
            history.pushState({ sortBy: 'lcsh' }, 'LCSH-luokan mukaan', '?by=lcsh');
            loadState();
        });
    }

    if ( queryParams.indexOf('by=lcc') === -1 ) {
        $('#col-lcc').unbind('click').on('click', function () {
            $( "tbody" ).addClass('faded');
            history.pushState({ sortBy: 'lcc' }, 'LCC-luokan mukaan', '?by=lcc');
            loadState();
        });
    }

    if ( queryParams.length !== 0 ) {
        $('#col-title').unbind('click').on('click', function () {
            $( "tbody" ).addClass('faded');
            history.pushState({ sortBy: 'title' }, 'Nimekkeen mukaan', 'index.html');
            loadState();
        });
    }



}

$(document).ready(function() {
    var queryParams = window.location.search.length > 0
                                                    ? window.location.search.substring(1).split('&')
                                                    : [];

    if ( queryParams.length === 0 ) {
        storage.setItem('by-title', $("tbody").children());
    }

    loadState();
    setClickHandlers();

});
