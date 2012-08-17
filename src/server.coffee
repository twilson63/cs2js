http = require 'http'
cc = require 'coffeecup'
cs = require 'coffee-script'
page = require './page'
sio = require 'socket.io'
filed = require 'filed'

server = http.createServer (req, res) ->
  if req.url == '/'
    res.writeHead 200, 'content-type': 'text/html'
    res.end cc.render(page, js: '', coffee: '')
  else
    filed('./public' + req.url).pipe(res)

io = sio.listen(server)
io.sockets.on 'connection', (socket) ->
  socket.on 'convert', (data) ->
    js = "could not convert"
    try 
      js = cs.compile(data, bare: on)
    catch err
      js = err.message
    finally
      socket.emit 'result', js

server.listen 7040
