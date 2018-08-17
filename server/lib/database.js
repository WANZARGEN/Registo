/**--------------------------------------------------------------------------*
 * 
 * @copyright Copyright (C) 2018 wanzargen@gmail.com.  All Rights Reserved.
 *
 *
 * @module database
 *
 * @description :: Database connector.
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

require('dotenv').config()

var mysql = require('mysql')



/**---------------------------------------------------------------------------*
 *                                  VARIABLES                                 *
 *----------------------------------------------------------------------------*/

var options = {
  host     : process.env.MYSQL_HOST,
  user     : process.env.MYSQL_USERNAME,
  password : process.env.MYSQL_PASSWORD,
  database : process.env.MYSQL_DATABASE,
  port     : process.env.MYSQL_PORT
}

var conn = mysql.createConnection(options)



/**---------------------------------------------------------------------------*
 *                                  FUNCTIONS                                 *
 *----------------------------------------------------------------------------*/

function handleDisconnect(client) {
	client.on('error', function (err) {
	    if (!err.fatal) return;
	    if (err.code !== 'PROTOCOL_CONNECTION_LOST') throw err;

	    console.error('> Re-connecting lost MySQL connection: ' + err.stack)

	    conn = mysql.createConnection(options)
	    handleDisconnect(conn);
	    conn.connect(function(err) {
        if(!err) console.log('DB connected as id ' + conn.threadId)
      })
  })
}



/**---------------------------------------------------------------------------*
 *                                   EXECUTE                                  *
 *----------------------------------------------------------------------------*/

handleDisconnect(conn)



/**---------------------------------------------------------------------------*
 *                                    EXPORTS                                 *
 *----------------------------------------------------------------------------*/

module.exports = conn