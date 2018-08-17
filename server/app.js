/**--------------------------------------------------------------------------*
 * 
 * @copyright Copyright (C) 2018 wanzargen@gmail.com.  All Rights Reserved.
 *
 *
 * @module app.js
 *
 * @description :: Server app module.
 * 
 * @author wanzargen
 * 
 * @since 2018-08-16
 * 
 * 
 *----------------------------------------------------------------------------*/



/**---------------------------------------------------------------------------*
 *                                   INCLUDE                                  *
 *----------------------------------------------------------------------------*/

var express   = require('express'),
path          = require('path'),
bodyParser    = require('body-parser'),
cookieParser  = require('cookie-parser'),
cors          = require('cors'),
logger        = require('morgan'),
db            = require('./lib/database.js'),
indexRouter   = require('./routes/index')


/**---------------------------------------------------------------------------*
 *                                  VARIABLES                                 *
 *----------------------------------------------------------------------------*/


var app = express();




/**---------------------------------------------------------------------------*
 *                                 MIDDLE WARES                               *
 *----------------------------------------------------------------------------*/

// Body-parser
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(cookieParser());

// Link SPA
app.use(express.static(path.join(__dirname, 'public')));

// Link Routers
app.use('/api', indexRouter);

// View engine setup
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')

// DB connection
db.connect(function(err) {
  if(!err) console.log('DB connected as id ' + db.threadId)
});


// Cross-origin setup
var whitelist = ['http://localhost:8080', 'http://localhost:80']
var corsOptions = {
  origin: function (origin, callback) {
    if (whitelist.indexOf(origin) !== -1) {
      callback(null, true)
    } else {
      callback(new Error('Not allowed by CORS'))
    }
  }
}
app.use(cors())
app.use(cors(corsOptions));


// Error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message
  res.locals.error = req.app.get('env') === 'development' ? err : {}

  // render the error page
  res.status(err.status || 500)
  res.render('error')
});

var detectDebug = function() {
  return process.env.NODE_ENV == 'development'
};



/**---------------------------------------------------------------------------*
 *                                      LOG                                   *
 *----------------------------------------------------------------------------*/

app.use(logger('dev'));

["log", "warn", "error"].forEach(function(fn) {

	var org = console[fn].bind(console);

	console[fn] = function() {

		var now = new Date();
		var arg = Array.prototype.slice.call(arguments);
		var tag = '[' + now.toTimeString().slice(0, 8) + '.' + now.getMilliseconds() + ']';

		arg.unshift(tag);

        org.apply(console, arg);
    };
});

console.log('\t  _______  _______  _______ _________ _______ _________ _______ ')
console.log('\t (  ____ )(  ____ \\(  ____ \\\\__   __/(  ____ \\\\__   __/(  ___  )')
console.log('\t | (    )|| (    \\/| (    \\/   ) (   | (    \\/   ) (   | (   ) |')
console.log('\t | (____)|| (__    | |         | |   | (_____    | |   | |   | |')
console.log('\t |     __)|  __)   | | ____    | |   (_____  )   | |   | |   | |')
console.log('\t | (\\ (   | (      | | \\_  )   | |         ) |   | |   | |   | |')
console.log('\t | ) \\ \\__| (____/\\| (___) |___) (___/\\____) |   | |   | (___) |')
console.log('\t |/   \\__/(_______/(_______)\\_______/\\_______)   )_(   (_______)')
console.log('\n')

console.log(detectDebug() ? "This is development mode." : "This is production mode.")



/**---------------------------------------------------------------------------*
 *                                    EXPORTS                                 *
 *----------------------------------------------------------------------------*/

module.exports = app
