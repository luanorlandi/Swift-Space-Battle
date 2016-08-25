
var Module;
if (typeof Module === 'undefined') Module = eval('(function() { try { return Module || {} } catch(e) { return {} } })()');
(function() {

    function fetchRemotePackage(packageName, callback, errback) {
      var xhr = new XMLHttpRequest();
      xhr.open('GET', packageName, true);
      xhr.responseType = 'arraybuffer';
      xhr.onprogress = function(event) {
        var url = packageName;
        if (event.loaded && event.total) {
          if (!xhr.addedTotal) {
            xhr.addedTotal = true;
            if (!Module.dataFileDownloads) Module.dataFileDownloads = {};
            Module.dataFileDownloads[url] = {
              loaded: event.loaded,
              total: event.total
            };
          } else {
            Module.dataFileDownloads[url].loaded = event.loaded;
          }
          var total = 0;
          var loaded = 0;
          var num = 0;
          for (var download in Module.dataFileDownloads) {
          var data = Module.dataFileDownloads[download];
            total += data.total;
            loaded += data.loaded;
            num++;
          }
          total = Math.ceil(total * Module.expectedDataFileDownloads/num);
          if (Module['setStatus']) Module['setStatus']('Downloading data... (' + loaded + '/' + total + ')');
        } else if (!Module.dataFileDownloads) {
          if (Module['setStatus']) Module['setStatus']('Downloading data...');
        }
      };
      xhr.onload = function(event) {
        var packageData = xhr.response;
        callback(packageData);
      };
      xhr.send(null);
    };

    function handleError(error) {
      console.error('package error:', error);
    };
  
      var fetched = null, fetchedCallback = null;
      fetchRemotePackage('moaiapp.rom', function(data) {
        if (fetchedCallback) {
          fetchedCallback(data);
          fetchedCallback = null;
        } else {
          fetched = data;
        }
      }, handleError);
    
  function runWithFS() {

function assert(check, msg) {
  if (!check) throw msg + new Error().stack;
}
Module['FS_createPath']('/', 'data', true, true);
Module['FS_createPath']('/data', 'effect', true, true);
Module['FS_createPath']('/data', 'input', true, true);
Module['FS_createPath']('/data', 'interface', true, true);
Module['FS_createPath']('/data/interface', 'game', true, true);
Module['FS_createPath']('/data/interface', 'intro', true, true);
Module['FS_createPath']('/data/interface', 'menu', true, true);
Module['FS_createPath']('/data', 'loop', true, true);
Module['FS_createPath']('/data', 'math', true, true);
Module['FS_createPath']('/data', 'menu', true, true);
Module['FS_createPath']('/data', 'player', true, true);
Module['FS_createPath']('/data', 'scenario', true, true);
Module['FS_createPath']('/data', 'screen', true, true);
Module['FS_createPath']('/data', 'ship', true, true);
Module['FS_createPath']('/data', 'shot', true, true);
Module['FS_createPath']('/data', 'spawn', true, true);
Module['FS_createPath']('/', 'file', true, true);
Module['FS_createPath']('/', 'font', true, true);
Module['FS_createPath']('/', 'texture', true, true);
Module['FS_createPath']('/texture', 'background', true, true);
Module['FS_createPath']('/texture', 'effect', true, true);
Module['FS_createPath']('/texture', 'logo', true, true);
Module['FS_createPath']('/texture', 'others', true, true);
Module['FS_createPath']('/texture', 'scenario', true, true);
Module['FS_createPath']('/texture', 'ship', true, true);
Module['FS_createPath']('/texture', 'shot', true, true);
Module['FS_createPath']('/texture/shot', 'low', true, true);

    function DataRequest(start, end, crunched, audio) {
      this.start = start;
      this.end = end;
      this.crunched = crunched;
      this.audio = audio;
    }
    DataRequest.prototype = {
      requests: {},
      open: function(mode, name) {
        this.name = name;
        this.requests[name] = this;
        Module['addRunDependency']('fp ' + this.name);
      },
      send: function() {},
      onload: function() {
        var byteArray = this.byteArray.subarray(this.start, this.end);
        if (this.crunched) {
          var ddsHeader = byteArray.subarray(0, 128);
          var that = this;
          requestDecrunch(this.name, byteArray.subarray(128), function(ddsData) {
            byteArray = new Uint8Array(ddsHeader.length + ddsData.length);
            byteArray.set(ddsHeader, 0);
            byteArray.set(ddsData, 128);
            that.finish(byteArray);
          });
        } else {
          this.finish(byteArray);
        }
      },
      finish: function(byteArray) {
        var that = this;
        Module['FS_createPreloadedFile'](this.name, null, byteArray, true, true, function() {
          Module['removeRunDependency']('fp ' + that.name);
        }, function() {
          if (that.audio) {
            Module['removeRunDependency']('fp ' + that.name); // workaround for chromium bug 124926 (still no audio with this, but at least we don't hang)
          } else {
            Module.printErr('Preloading file ' + that.name + ' failed');
          }
        }, false, true); // canOwn this data in the filesystem, it is a slide into the heap that will never change
        this.requests[this.name] = null;
      },
    };
      new DataRequest(0, 1581, 0, 0).open('GET', '/main.lua');
    new DataRequest(1581, 2258, 0, 0).open('GET', '/data/effect/blackscreen.lua');
    new DataRequest(2258, 3045, 0, 0).open('GET', '/data/effect/blend.lua');
    new DataRequest(3045, 3337, 0, 0).open('GET', '/data/effect/blink.lua');
    new DataRequest(3337, 5072, 0, 0).open('GET', '/data/effect/explosion.lua');
    new DataRequest(5072, 5751, 0, 0).open('GET', '/data/effect/spawnblink.lua');
    new DataRequest(5751, 6549, 0, 0).open('GET', '/data/input/input.lua');
    new DataRequest(6549, 7081, 0, 0).open('GET', '/data/input/keyboard.lua');
    new DataRequest(7081, 8547, 0, 0).open('GET', '/data/input/mouse.lua');
    new DataRequest(8547, 9740, 0, 0).open('GET', '/data/input/touch.lua');
    new DataRequest(9740, 9950, 0, 0).open('GET', '/data/interface/priority.lua');
    new DataRequest(9950, 11041, 0, 0).open('GET', '/data/interface/game/borderHp.lua');
    new DataRequest(11041, 13160, 0, 0).open('GET', '/data/interface/game/gameInterface.lua');
    new DataRequest(13160, 17104, 0, 0).open('GET', '/data/interface/game/gameOver.lua');
    new DataRequest(17104, 17737, 0, 0).open('GET', '/data/interface/game/gameText.lua');
    new DataRequest(17737, 18946, 0, 0).open('GET', '/data/interface/game/lives.lua');
    new DataRequest(18946, 22041, 0, 0).open('GET', '/data/interface/game/scoreText.lua');
    new DataRequest(22041, 25393, 0, 0).open('GET', '/data/interface/intro/introInterface.lua');
    new DataRequest(25393, 25932, 0, 0).open('GET', '/data/interface/menu/background.lua');
    new DataRequest(25932, 28226, 0, 0).open('GET', '/data/interface/menu/menuInterface.lua');
    new DataRequest(28226, 29494, 0, 0).open('GET', '/data/interface/menu/menuText.lua');
    new DataRequest(29494, 30017, 0, 0).open('GET', '/data/interface/menu/title.lua');
    new DataRequest(30017, 31085, 0, 0).open('GET', '/data/loop/ingame.lua');
    new DataRequest(31085, 31451, 0, 0).open('GET', '/data/loop/inintro.lua');
    new DataRequest(31451, 31764, 0, 0).open('GET', '/data/loop/inmenu.lua');
    new DataRequest(31764, 33966, 0, 0).open('GET', '/data/loop/thread.lua');
    new DataRequest(33966, 35099, 0, 0).open('GET', '/data/math/area.lua');
    new DataRequest(35099, 36705, 0, 0).open('GET', '/data/math/rectangle.lua');
    new DataRequest(36705, 36906, 0, 0).open('GET', '/data/math/util.lua');
    new DataRequest(36906, 37415, 0, 0).open('GET', '/data/math/vector.lua');
    new DataRequest(37415, 43357, 0, 0).open('GET', '/data/menu/data.lua');
    new DataRequest(43357, 45628, 0, 0).open('GET', '/data/player/data.lua');
    new DataRequest(45628, 46466, 0, 0).open('GET', '/data/player/level.lua');
    new DataRequest(46466, 47215, 0, 0).open('GET', '/data/scenario/scenario.lua');
    new DataRequest(47215, 48737, 0, 0).open('GET', '/data/scenario/stage1.lua');
    new DataRequest(48737, 51832, 0, 0).open('GET', '/data/screen/screen.lua');
    new DataRequest(51832, 52069, 0, 0).open('GET', '/data/ship/enemies.lua');
    new DataRequest(52069, 54921, 0, 0).open('GET', '/data/ship/enemyType1.lua');
    new DataRequest(54921, 57182, 0, 0).open('GET', '/data/ship/enemyType2.lua');
    new DataRequest(57182, 59991, 0, 0).open('GET', '/data/ship/enemyType3.lua');
    new DataRequest(59991, 64014, 0, 0).open('GET', '/data/ship/enemyType4.lua');
    new DataRequest(64014, 67050, 0, 0).open('GET', '/data/ship/enemyType5.lua');
    new DataRequest(67050, 69945, 0, 0).open('GET', '/data/ship/player.lua');
    new DataRequest(69945, 79547, 0, 0).open('GET', '/data/ship/ship.lua');
    new DataRequest(79547, 81870, 0, 0).open('GET', '/data/shot/shot.lua');
    new DataRequest(81870, 82521, 0, 0).open('GET', '/data/shot/shotLaserBlue.lua');
    new DataRequest(82521, 83172, 0, 0).open('GET', '/data/shot/shotLaserCyan.lua');
    new DataRequest(83172, 83830, 0, 0).open('GET', '/data/shot/shotLaserGreen.lua');
    new DataRequest(83830, 84502, 0, 0).open('GET', '/data/shot/shotLaserMagenta.lua');
    new DataRequest(84502, 85146, 0, 0).open('GET', '/data/shot/shotLaserRed.lua');
    new DataRequest(85146, 85707, 0, 0).open('GET', '/data/shot/shotStar.lua');
    new DataRequest(85707, 86389, 0, 0).open('GET', '/data/spawn/shipClass.lua');
    new DataRequest(86389, 94353, 0, 0).open('GET', '/data/spawn/spawner.lua');
    new DataRequest(94353, 94425, 0, 0).open('GET', '/file/listOfResolutions.lua');
    new DataRequest(94425, 94426, 0, 0).open('GET', '/file/options.lua');
    new DataRequest(94426, 94428, 0, 0).open('GET', '/file/score.lua');
    new DataRequest(94428, 186168, 0, 0).open('GET', '/font/recharge bd.ttf');
    new DataRequest(186168, 212424, 0, 0).open('GET', '/font/RosesareFF0000.ttf');
    new DataRequest(212424, 212600, 0, 0).open('GET', '/font/source.txt');
    new DataRequest(212600, 233956, 0, 0).open('GET', '/font/zekton free.ttf');
    new DataRequest(233956, 862661, 0, 0).open('GET', '/texture/background/menuBackground.png');
    new DataRequest(862661, 862790, 0, 0).open('GET', '/texture/effect/blackscreen.png');
    new DataRequest(862790, 875641, 0, 0).open('GET', '/texture/effect/borderhp.png');
    new DataRequest(875641, 3832544, 0, 0).open('GET', '/texture/effect/expType1 original.png');
    new DataRequest(3832544, 4871532, 0, 0).open('GET', '/texture/effect/expType1.png');
    new DataRequest(4871532, 6790780, 0, 0).open('GET', '/texture/effect/expType2 original.png');
    new DataRequest(6790780, 7186905, 0, 0).open('GET', '/texture/effect/expType2.png');
    new DataRequest(7186905, 7197562, 0, 0).open('GET', '/texture/effect/muzzleflash.png');
    new DataRequest(7197562, 7203056, 0, 0).open('GET', '/texture/effect/muzzleflash11.jpg');
    new DataRequest(7203056, 7208525, 0, 0).open('GET', '/texture/effect/muzzleflashCyan.png');
    new DataRequest(7208525, 7215427, 0, 0).open('GET', '/texture/effect/muzzleflashRed.png');
    new DataRequest(7215427, 7215554, 0, 0).open('GET', '/texture/effect/whitescreen.png');
    new DataRequest(7215554, 7220359, 0, 0).open('GET', '/texture/logo/lua.gif');
    new DataRequest(7220359, 7338173, 0, 0).open('GET', '/texture/logo/lua.png');
    new DataRequest(7338173, 7386803, 0, 0).open('GET', '/texture/logo/moai.png');
    new DataRequest(7386803, 7445947, 0, 0).open('GET', '/texture/logo/moaiattribution_vert_white.png');
    new DataRequest(7445947, 7714783, 0, 0).open('GET', '/texture/logo/title.png');
    new DataRequest(7714783, 15383599, 0, 0).open('GET', '/texture/others/asd.psd');
    new DataRequest(15383599, 15517234, 0, 0).open('GET', '/texture/others/howToPlay.png');
    new DataRequest(15517234, 21254676, 0, 0).open('GET', '/texture/others/howToPlay.psd');
    new DataRequest(21254676, 21314896, 0, 0).open('GET', '/texture/others/key a.png');
    new DataRequest(21314896, 21372259, 0, 0).open('GET', '/texture/others/key d.png');
    new DataRequest(21372259, 21434664, 0, 0).open('GET', '/texture/others/key s.png');
    new DataRequest(21434664, 21498085, 0, 0).open('GET', '/texture/others/key w.png');
    new DataRequest(21498085, 21547036, 0, 0).open('GET', '/texture/others/key.jpg');
    new DataRequest(21547036, 21574395, 0, 0).open('GET', '/texture/scenario/bigStars.png');
    new DataRequest(21574395, 22112886, 0, 0).open('GET', '/texture/scenario/littleStars.png');
    new DataRequest(22112886, 22315635, 0, 0).open('GET', '/texture/scenario/Star.jpg');
    new DataRequest(22315635, 22337345, 0, 0).open('GET', '/texture/scenario/star.png');
    new DataRequest(22337345, 22871692, 0, 0).open('GET', '/texture/scenario/Stars-Space.jpg');
    new DataRequest(22871692, 23437613, 0, 0).open('GET', '/texture/ship/5c2.png');
    new DataRequest(23437613, 23953303, 0, 0).open('GET', '/texture/ship/5concepts.png');
    new DataRequest(23953303, 23972027, 0, 0).open('GET', '/texture/ship/ship10.png');
    new DataRequest(23972027, 23993054, 0, 0).open('GET', '/texture/ship/ship10dmg.png');
    new DataRequest(23993054, 24007064, 0, 0).open('GET', '/texture/ship/ship5.png');
    new DataRequest(24007064, 24020514, 0, 0).open('GET', '/texture/ship/ship5dmg.png');
    new DataRequest(24020514, 24038726, 0, 0).open('GET', '/texture/ship/ship6.png');
    new DataRequest(24038726, 24056162, 0, 0).open('GET', '/texture/ship/ship6dmg.png');
    new DataRequest(24056162, 24070846, 0, 0).open('GET', '/texture/ship/ship7.png');
    new DataRequest(24070846, 24085019, 0, 0).open('GET', '/texture/ship/ship7dmg.png');
    new DataRequest(24085019, 24102205, 0, 0).open('GET', '/texture/ship/ship8.png');
    new DataRequest(24102205, 24119983, 0, 0).open('GET', '/texture/ship/ship8dmg.png');
    new DataRequest(24119983, 24138228, 0, 0).open('GET', '/texture/ship/ship9.png');
    new DataRequest(24138228, 24155707, 0, 0).open('GET', '/texture/ship/ship9dmg.png');
    new DataRequest(24155707, 24161132, 0, 0).open('GET', '/texture/shot/laserblue.png');
    new DataRequest(24161132, 24166515, 0, 0).open('GET', '/texture/shot/lasercyan.png');
    new DataRequest(24166515, 24171954, 0, 0).open('GET', '/texture/shot/lasergreen.png');
    new DataRequest(24171954, 24177195, 0, 0).open('GET', '/texture/shot/lasermagenta.png');
    new DataRequest(24177195, 24182521, 0, 0).open('GET', '/texture/shot/laserred.png');
    new DataRequest(24182521, 24198205, 0, 0).open('GET', '/texture/shot/starshot.png');
    new DataRequest(24198205, 24201132, 0, 0).open('GET', '/texture/shot/low/lasergreen.png');

    if (!Module.expectedDataFileDownloads) {
      Module.expectedDataFileDownloads = 0;
      Module.finishedDataFileDownloads = 0;
    }
    Module.expectedDataFileDownloads++;

    var PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    var PACKAGE_NAME = 'C:/Users/orlan/Dropbox/MOAI/moaicli-windows.1.5.0-rc3/SwiftSpaceBattle/distribute/html/html-debug/www/moaiapp.rom';
    var REMOTE_PACKAGE_NAME = 'moaiapp.rom';
    var PACKAGE_UUID = 'dddf4056-2488-4951-881a-2f929302ddbe';
  
    function processPackageData(arrayBuffer) {
      Module.finishedDataFileDownloads++;
      assert(arrayBuffer, 'Loading data file failed.');
      var byteArray = new Uint8Array(arrayBuffer);
      var curr;
      
      // copy the entire loaded file into a spot in the heap. Files will refer to slices in that. They cannot be freed though.
      var ptr = Module['_malloc'](byteArray.length);
      Module['HEAPU8'].set(byteArray, ptr);
      DataRequest.prototype.byteArray = Module['HEAPU8'].subarray(ptr, ptr+byteArray.length);
          DataRequest.prototype.requests["/main.lua"].onload();
          DataRequest.prototype.requests["/data/effect/blackscreen.lua"].onload();
          DataRequest.prototype.requests["/data/effect/blend.lua"].onload();
          DataRequest.prototype.requests["/data/effect/blink.lua"].onload();
          DataRequest.prototype.requests["/data/effect/explosion.lua"].onload();
          DataRequest.prototype.requests["/data/effect/spawnblink.lua"].onload();
          DataRequest.prototype.requests["/data/input/input.lua"].onload();
          DataRequest.prototype.requests["/data/input/keyboard.lua"].onload();
          DataRequest.prototype.requests["/data/input/mouse.lua"].onload();
          DataRequest.prototype.requests["/data/input/touch.lua"].onload();
          DataRequest.prototype.requests["/data/interface/priority.lua"].onload();
          DataRequest.prototype.requests["/data/interface/game/borderHp.lua"].onload();
          DataRequest.prototype.requests["/data/interface/game/gameInterface.lua"].onload();
          DataRequest.prototype.requests["/data/interface/game/gameOver.lua"].onload();
          DataRequest.prototype.requests["/data/interface/game/gameText.lua"].onload();
          DataRequest.prototype.requests["/data/interface/game/lives.lua"].onload();
          DataRequest.prototype.requests["/data/interface/game/scoreText.lua"].onload();
          DataRequest.prototype.requests["/data/interface/intro/introInterface.lua"].onload();
          DataRequest.prototype.requests["/data/interface/menu/background.lua"].onload();
          DataRequest.prototype.requests["/data/interface/menu/menuInterface.lua"].onload();
          DataRequest.prototype.requests["/data/interface/menu/menuText.lua"].onload();
          DataRequest.prototype.requests["/data/interface/menu/title.lua"].onload();
          DataRequest.prototype.requests["/data/loop/ingame.lua"].onload();
          DataRequest.prototype.requests["/data/loop/inintro.lua"].onload();
          DataRequest.prototype.requests["/data/loop/inmenu.lua"].onload();
          DataRequest.prototype.requests["/data/loop/thread.lua"].onload();
          DataRequest.prototype.requests["/data/math/area.lua"].onload();
          DataRequest.prototype.requests["/data/math/rectangle.lua"].onload();
          DataRequest.prototype.requests["/data/math/util.lua"].onload();
          DataRequest.prototype.requests["/data/math/vector.lua"].onload();
          DataRequest.prototype.requests["/data/menu/data.lua"].onload();
          DataRequest.prototype.requests["/data/player/data.lua"].onload();
          DataRequest.prototype.requests["/data/player/level.lua"].onload();
          DataRequest.prototype.requests["/data/scenario/scenario.lua"].onload();
          DataRequest.prototype.requests["/data/scenario/stage1.lua"].onload();
          DataRequest.prototype.requests["/data/screen/screen.lua"].onload();
          DataRequest.prototype.requests["/data/ship/enemies.lua"].onload();
          DataRequest.prototype.requests["/data/ship/enemyType1.lua"].onload();
          DataRequest.prototype.requests["/data/ship/enemyType2.lua"].onload();
          DataRequest.prototype.requests["/data/ship/enemyType3.lua"].onload();
          DataRequest.prototype.requests["/data/ship/enemyType4.lua"].onload();
          DataRequest.prototype.requests["/data/ship/enemyType5.lua"].onload();
          DataRequest.prototype.requests["/data/ship/player.lua"].onload();
          DataRequest.prototype.requests["/data/ship/ship.lua"].onload();
          DataRequest.prototype.requests["/data/shot/shot.lua"].onload();
          DataRequest.prototype.requests["/data/shot/shotLaserBlue.lua"].onload();
          DataRequest.prototype.requests["/data/shot/shotLaserCyan.lua"].onload();
          DataRequest.prototype.requests["/data/shot/shotLaserGreen.lua"].onload();
          DataRequest.prototype.requests["/data/shot/shotLaserMagenta.lua"].onload();
          DataRequest.prototype.requests["/data/shot/shotLaserRed.lua"].onload();
          DataRequest.prototype.requests["/data/shot/shotStar.lua"].onload();
          DataRequest.prototype.requests["/data/spawn/shipClass.lua"].onload();
          DataRequest.prototype.requests["/data/spawn/spawner.lua"].onload();
          DataRequest.prototype.requests["/file/listOfResolutions.lua"].onload();
          DataRequest.prototype.requests["/file/options.lua"].onload();
          DataRequest.prototype.requests["/file/score.lua"].onload();
          DataRequest.prototype.requests["/font/recharge bd.ttf"].onload();
          DataRequest.prototype.requests["/font/RosesareFF0000.ttf"].onload();
          DataRequest.prototype.requests["/font/source.txt"].onload();
          DataRequest.prototype.requests["/font/zekton free.ttf"].onload();
          DataRequest.prototype.requests["/texture/background/menuBackground.png"].onload();
          DataRequest.prototype.requests["/texture/effect/blackscreen.png"].onload();
          DataRequest.prototype.requests["/texture/effect/borderhp.png"].onload();
          DataRequest.prototype.requests["/texture/effect/expType1 original.png"].onload();
          DataRequest.prototype.requests["/texture/effect/expType1.png"].onload();
          DataRequest.prototype.requests["/texture/effect/expType2 original.png"].onload();
          DataRequest.prototype.requests["/texture/effect/expType2.png"].onload();
          DataRequest.prototype.requests["/texture/effect/muzzleflash.png"].onload();
          DataRequest.prototype.requests["/texture/effect/muzzleflash11.jpg"].onload();
          DataRequest.prototype.requests["/texture/effect/muzzleflashCyan.png"].onload();
          DataRequest.prototype.requests["/texture/effect/muzzleflashRed.png"].onload();
          DataRequest.prototype.requests["/texture/effect/whitescreen.png"].onload();
          DataRequest.prototype.requests["/texture/logo/lua.gif"].onload();
          DataRequest.prototype.requests["/texture/logo/lua.png"].onload();
          DataRequest.prototype.requests["/texture/logo/moai.png"].onload();
          DataRequest.prototype.requests["/texture/logo/moaiattribution_vert_white.png"].onload();
          DataRequest.prototype.requests["/texture/logo/title.png"].onload();
          DataRequest.prototype.requests["/texture/others/asd.psd"].onload();
          DataRequest.prototype.requests["/texture/others/howToPlay.png"].onload();
          DataRequest.prototype.requests["/texture/others/howToPlay.psd"].onload();
          DataRequest.prototype.requests["/texture/others/key a.png"].onload();
          DataRequest.prototype.requests["/texture/others/key d.png"].onload();
          DataRequest.prototype.requests["/texture/others/key s.png"].onload();
          DataRequest.prototype.requests["/texture/others/key w.png"].onload();
          DataRequest.prototype.requests["/texture/others/key.jpg"].onload();
          DataRequest.prototype.requests["/texture/scenario/bigStars.png"].onload();
          DataRequest.prototype.requests["/texture/scenario/littleStars.png"].onload();
          DataRequest.prototype.requests["/texture/scenario/Star.jpg"].onload();
          DataRequest.prototype.requests["/texture/scenario/star.png"].onload();
          DataRequest.prototype.requests["/texture/scenario/Stars-Space.jpg"].onload();
          DataRequest.prototype.requests["/texture/ship/5c2.png"].onload();
          DataRequest.prototype.requests["/texture/ship/5concepts.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship10.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship10dmg.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship5.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship5dmg.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship6.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship6dmg.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship7.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship7dmg.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship8.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship8dmg.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship9.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship9dmg.png"].onload();
          DataRequest.prototype.requests["/texture/shot/laserblue.png"].onload();
          DataRequest.prototype.requests["/texture/shot/lasercyan.png"].onload();
          DataRequest.prototype.requests["/texture/shot/lasergreen.png"].onload();
          DataRequest.prototype.requests["/texture/shot/lasermagenta.png"].onload();
          DataRequest.prototype.requests["/texture/shot/laserred.png"].onload();
          DataRequest.prototype.requests["/texture/shot/starshot.png"].onload();
          DataRequest.prototype.requests["/texture/shot/low/lasergreen.png"].onload();
          Module['removeRunDependency']('datafile_C:/Users/orlan/Dropbox/MOAI/moaicli-windows.1.5.0-rc3/SwiftSpaceBattle/distribute/html/html-debug/www/moaiapp.rom');

    };
    Module['addRunDependency']('datafile_C:/Users/orlan/Dropbox/MOAI/moaicli-windows.1.5.0-rc3/SwiftSpaceBattle/distribute/html/html-debug/www/moaiapp.rom');
  
    if (!Module.preloadResults) Module.preloadResults = {};
  
      Module.preloadResults[PACKAGE_NAME] = {fromCache: false};
      if (fetched) {
        processPackageData(fetched);
        fetched = null;
      } else {
        fetchedCallback = processPackageData;
      }
    
  }
  if (Module['calledRun']) {
    runWithFS();
  } else {
    if (!Module['preRun']) Module['preRun'] = [];
    Module["preRun"].push(runWithFS); // FS is not initialized yet, wait for it
  }

})();
