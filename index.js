$(document).ready(function() {
    console.log("hello");
    $('table').tablesorter({
        dateFormat: "yyyy-mm-dd",

        usNumberFormat: false,


        ignoreCase: true,


        sortLocaleCompare: true,

        debug: false,

    });
});
