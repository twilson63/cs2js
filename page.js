
module.exports = function() {
  doctype(5);
  return html(function() {
    head(function() {
      title('coffeescript to javascript');
      meta({
        name: 'description',
        content: 'Convert CoffeeScript 2 Javascript'
      });
      meta({
        name: 'keywords',
        content: 'coffeescript, javascript, convert coffeescript to javascript'
      });
      meta({
        name: 'viewport',
        content: 'width=device-width, initial-scale=1, maximum-scale=1'
      });
      link({
        href: 'http://fonts.googleapis.com/css?family=Orbitron',
        rel: 'stylesheet',
        type: 'text/css'
      });
      link({
        rel: 'stylesheet',
        href: '/stylesheets/base.css'
      });
      link({
        rel: 'stylesheet',
        href: '/stylesheets/skeleton.css'
      });
      link({
        rel: 'stylesheet',
        href: '/stylesheets/layout.css'
      });
      return comment('[if lt IE 9]>\r\n\t<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>\r\n<![endif]');
    });
    return body(function() {
      div('.container', function() {
        div('.row', {
          style: 'margin-top: 25px;'
        }, function() {
          return div('.twelve.columns', function() {
            return h3('.fit', {
              style: 'color: rgba(0,0,0,.7);'
            }, 'Coffeescript to Javascript');
          });
        });
        form({
          method: 'POST',
          action: '/convert'
        }, function() {
          div('.row', function() {
            return div('.twelve.columns', function() {
              return textarea({
                name: 'coffeescript',
                placeholder: 'square = (x) -> x * x',
                style: 'height:150px;width:98%'
              }, function() {
                return this.js;
              });
            });
          });
          div('.row', function() {
            div('.six.columns', function() {
              return a('.button', {
                href: '#',
                style: 'width:90%;'
              }, 'CONVERT');
            });
            return div('.six.columns', function() {
              return a('.button', {
                href: '#',
                style: 'width: 90%'
              }, 'RESET');
            });
          });
          return div('#results.row', {
            style: 'display:none;'
          }, function() {
            return div('.twelve.columns', function() {
              return textarea({
                name: 'javascript',
                style: 'height:150px;width:98%'
              }, function() {
                return this.coffee;
              });
            });
          });
        });
        div('.row', function() {
          return div('.twelve.columns', function() {
            return h3('.fit', {
              style: 'color: rgba(0,0,0,.7);'
            }, 'News and Updates');
          });
        });
        return div('.row', {
          style: 'margin-bottom: 100px;'
        }, function() {
          div('.four.columns', function() {
            return iframe({
              src: 'http://markdotto.github.com/github-buttons/github-btn.html?user=twilson63&repo=cs2js&type=watch',
              allowtransparency: true,
              frameborder: "0",
              scrolling: "0",
              width: "62px",
              height: "20px;"
            });
          });
          div('.four.columns', function() {
            a('.twitter-share-button', {
              href: 'https://twitter.com/share',
              'data-url': 'http://cs2js.nodejitsu.com',
              'data-text': 'Convert your coffeescript to javascript! #coffeescript #nodejs'
            }, 'Tweet');
            return script('!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");');
          });
          return div('.four.columns', function() {
            a('.twitter-follow-button', {
              href: 'https://twitter.com/twilson63',
              'data-show-count': 'false'
            }, 'Follow');
            return script('!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");');
          });
        });
      });
      script({
        src: 'http://cdnjs.cloudflare.com/ajax/libs/jquery/1.7.1/jquery.min.js'
      });
      script({
        src: '/javascripts/fittext.js'
      });
      script({
        src: '/socket.io/socket.io.js'
      });
      return coffeescript(function() {
        return $(function() {
          var socket;
          socket = io.connect();
          socket.on('result', function(cs) {
            $('textarea[name=javascript]').text(cs);
            return $('#results').show();
          });
          $('.fit').fitText(1.2, {
            minFontSize: '13px',
            maxFontSize: '40px'
          });
          $('form').submit(function(e) {
            e.preventDefault();
            socket.emit('convert', $('textarea[name=coffeescript]', this).val());
            return false;
          });
          return $('form a').click(function(e) {
            return $('textarea').val('');
          });
        });
      });
    });
  });
};
