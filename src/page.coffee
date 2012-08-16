module.exports = ->
  doctype 5
  html ->
    head ->
      title 'coffeescript to javascript'
      meta name: 'description', content: 'Convert CoffeeScript 2 Javascript'
      meta name: 'keywords', content: 'coffeescript, javascript, convert coffeescript to javascript'
      meta name: 'viewport', content: 'width=device-width, initial-scale=1, maximum-scale=1'
      link href: 'http://fonts.googleapis.com/css?family=Orbitron', rel: 'stylesheet', type: 'text/css'
      link rel: 'stylesheet', href: '/stylesheets/base.css'
      link rel: 'stylesheet', href: '/stylesheets/skeleton.css'
      link rel: 'stylesheet', href: '/stylesheets/layout.css'
      link rel: 'stylesheet', href: '/stylesheets/app.css'
      comment '[if lt IE 9]>\r\n\t<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>\r\n<![endif]'
    body ->
      div '.container', ->
        div '.row', style: 'margin-top: 25px;', ->
          div '.twelve.columns', ->
            h3 '.fit', 'Coffeescript to Javascript'
        form ->
          div '.row', ->
            div '.twelve.columns', ->
              textarea name: 'coffeescript', placeholder: 'square = (x) -> x * x'
          div '.row', ->
            div '.six.columns', -> a '#convert.button', href: '#', 'CONVERT'
            div '.six.columns', -> a '#reset.button', href: '#', 'RESET'
          div '#results.row', ->
            div '.twelve.columns', -> textarea name: 'javascript'
        div '.row', ->
          div '.twelve.columns', ->
            h3 '.fit', 'News and Updates'
        div '.row', style: 'margin-bottom: 100px;', ->
          div '.four.columns', ->
            text '&nbsp;'
            #iframe src: 'http://markdotto.github.com/github-buttons/github-btn.html?user=twilson63&repo=cs2js&type=watch', allowtransparency: true, frameborder: "0", scrolling: "0", width: "62px", height: "20px;"
          div '.four.columns', ->
            a '.twitter-share-button', href: 'https://twitter.com/share', 'data-url': 'http://cs2js.nodejitsu.com', 'data-text': 'Convert your coffeescript to javascript! #coffeescript #nodejs', 'Tweet'
            script '!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");'
          div '.four.columns', ->
            a '.twitter-follow-button', href: 'https://twitter.com/twilson63', 'data-show-count': 'false', 'Follow'
            script '!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");'
      script src: 'http://cdnjs.cloudflare.com/ajax/libs/jquery/1.7.1/jquery.min.js'
      script src: '/javascripts/fittext.js'
      script src: '/socket.io/socket.io.js'
      text '''
      <script type="text/javascript">
        var _gauges = _gauges || [];
        (function() {
          var t   = document.createElement('script');
          t.type  = 'text/javascript';
          t.async = true;
          t.id    = 'gauges-tracker';
          t.setAttribute('data-site-id', '4fac806df5a1f54ded000001');
          t.src = '//secure.gaug.es/track.js';
          var s = document.getElementsByTagName('script')[0];
          s.parentNode.insertBefore(t, s);
        })();
      </script>    
      '''
      coffeescript ->
        $ ->
          socket = io.connect()
          socket.on 'result', (js) -> $('textarea[name=javascript]').val(js); $('#results').show()
          $('.fit').fitText(1.2, { minFontSize: '13px', maxFontSize: '40px' })
          $('#convert').click -> socket.emit 'convert', $('textarea[name=coffeescript]').val()
          $('#reset').click -> $('textarea').val(''); $('#results').hide()

