var http = require("http");
var fs = require("fs");
var os = require("os");
var ip = require('ip');

var days = (os.uptime() / 86400 >> 0)
var hrs = ((os.uptime() / 3600) - days*24 >> 0)
var min = ((os.uptime() / 60) - days*24*60 - hrs*60 >> 0)
var sec = ((os.uptime()) - (days*24*60*60) - (hrs*60*60) - (min*60) >> 0)

http.createServer(function(req, res){

    if (req.url === "/") {
        fs.readFile("./public/index.html", "UTF-8", function(err, body){
        res.writeHead(200, {"Content-Type": "text/html"});
        res.end(body);
    });
}
    else if(req.url.match("/sysinfo")) {
        myHostName=os.hostname();
        html=`    
        <!DOCTYPE html>
        <html>
          <head>
            <title>Node JS Response</title>
          </head>
          <body>
            <p>Hostname: ${myHostName}</p>
            <p>IP: ${ip.address()}</p>
            <p>Server Uptime: ${("Days: " + days ) + (" Hours: " + hrs ) + (" Minutes: " + min ) + (" Seconds: " + sec ) }</p>
            <p>Total Memory: ${os.totalmem()/1000000 + " MB"} </p>
            <p>Free Memory: ${os.freemem()/1000000 + " MB"} </p>
            <p>Number of CPUs: ${os.cpus().length} </p>            
          </body>
        </html>` 
        res.writeHead(200, {"Content-Type": "text/html"});
        res.end(html);
    }
    else {
        res.writeHead(404, {"Content-Type": "text/plain"});
        res.end(`404 File Not Found at ${req.url}`);
    }
}).listen(3000);

console.log("Server listening on port 3000");
