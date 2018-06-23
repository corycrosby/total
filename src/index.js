'use strict';

require('./index.html');

const Elm = require('./Main.elm');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
Elm.Main.embed(document.getElementById('main'));