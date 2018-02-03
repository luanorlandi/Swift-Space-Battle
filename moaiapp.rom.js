
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
Module['FS_createPath']('/', 'effect', true, true);
Module['FS_createPath']('/', 'file', true, true);
Module['FS_createPath']('/file', 'language', true, true);
Module['FS_createPath']('/', 'font', true, true);
Module['FS_createPath']('/', 'input', true, true);
Module['FS_createPath']('/', 'interface', true, true);
Module['FS_createPath']('/interface', 'game', true, true);
Module['FS_createPath']('/interface', 'intro', true, true);
Module['FS_createPath']('/interface', 'menu', true, true);
Module['FS_createPath']('/', 'loop', true, true);
Module['FS_createPath']('/', 'math', true, true);
Module['FS_createPath']('/', 'menu', true, true);
Module['FS_createPath']('/', 'player', true, true);
Module['FS_createPath']('/', 'scenario', true, true);
Module['FS_createPath']('/', 'ship', true, true);
Module['FS_createPath']('/', 'shot', true, true);
Module['FS_createPath']('/', 'spawn', true, true);
Module['FS_createPath']('/', 'texture', true, true);
Module['FS_createPath']('/texture', 'background', true, true);
Module['FS_createPath']('/texture', 'effect', true, true);
Module['FS_createPath']('/texture', 'logo', true, true);
Module['FS_createPath']('/texture', 'others', true, true);
Module['FS_createPath']('/texture', 'scenario', true, true);
Module['FS_createPath']('/texture', 'ship', true, true);
Module['FS_createPath']('/texture', 'shot', true, true);
Module['FS_createPath']('/texture/shot', 'low', true, true);
Module['FS_createPath']('/', 'window', true, true);

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
      new DataRequest(0, 1109, 0, 0).open('GET', '/main.lua');
    new DataRequest(1109, 1788, 0, 0).open('GET', '/effect/blackscreen.lua');
    new DataRequest(1788, 2575, 0, 0).open('GET', '/effect/blend.lua');
    new DataRequest(2575, 2867, 0, 0).open('GET', '/effect/blink.lua');
    new DataRequest(2867, 4734, 0, 0).open('GET', '/effect/explosion.lua');
    new DataRequest(4734, 5413, 0, 0).open('GET', '/effect/spawnblink.lua');
    new DataRequest(5413, 5461, 0, 0).open('GET', '/file/button.lua');
    new DataRequest(5461, 5533, 0, 0).open('GET', '/file/resolutions.lua');
    new DataRequest(5533, 6135, 0, 0).open('GET', '/file/saveLocation.lua');
    new DataRequest(6135, 7900, 0, 0).open('GET', '/file/strings.lua');
    new DataRequest(7900, 8448, 0, 0).open('GET', '/file/language/cs.lua');
    new DataRequest(8448, 8954, 0, 0).open('GET', '/file/language/da.lua');
    new DataRequest(8954, 9511, 0, 0).open('GET', '/file/language/de.lua');
    new DataRequest(9511, 10189, 0, 0).open('GET', '/file/language/el.lua');
    new DataRequest(10189, 10707, 0, 0).open('GET', '/file/language/en.lua');
    new DataRequest(10707, 11260, 0, 0).open('GET', '/file/language/es.lua');
    new DataRequest(11260, 11807, 0, 0).open('GET', '/file/language/fr.lua');
    new DataRequest(11807, 12376, 0, 0).open('GET', '/file/language/hu.lua');
    new DataRequest(12376, 12919, 0, 0).open('GET', '/file/language/id.lua');
    new DataRequest(12919, 13459, 0, 0).open('GET', '/file/language/it.lua');
    new DataRequest(13459, 14002, 0, 0).open('GET', '/file/language/nb.lua');
    new DataRequest(14002, 14548, 0, 0).open('GET', '/file/language/nl.lua');
    new DataRequest(14548, 15104, 0, 0).open('GET', '/file/language/pt.lua');
    new DataRequest(15104, 15803, 0, 0).open('GET', '/file/language/ru.lua');
    new DataRequest(15803, 16347, 0, 0).open('GET', '/file/language/sv.lua');
    new DataRequest(16347, 17096, 0, 0).open('GET', '/file/language/uk.lua');
    new DataRequest(17096, 28656, 0, 0).open('GET', '/font/LICENSE-NotoSans-Regular.txt');
    new DataRequest(28656, 443476, 0, 0).open('GET', '/font/NotoSans-Regular.ttf');
    new DataRequest(443476, 444573, 0, 0).open('GET', '/input/input.lua');
    new DataRequest(444573, 445501, 0, 0).open('GET', '/input/keyboard.lua');
    new DataRequest(445501, 446273, 0, 0).open('GET', '/input/mouse.lua');
    new DataRequest(446273, 449075, 0, 0).open('GET', '/input/touch.lua');
    new DataRequest(449075, 449285, 0, 0).open('GET', '/interface/priority.lua');
    new DataRequest(449285, 450448, 0, 0).open('GET', '/interface/game/borderHp.lua');
    new DataRequest(450448, 454930, 0, 0).open('GET', '/interface/game/buttons.lua');
    new DataRequest(454930, 457360, 0, 0).open('GET', '/interface/game/gameInterface.lua');
    new DataRequest(457360, 460778, 0, 0).open('GET', '/interface/game/gameOver.lua');
    new DataRequest(460778, 461425, 0, 0).open('GET', '/interface/game/gameText.lua');
    new DataRequest(461425, 462603, 0, 0).open('GET', '/interface/game/lives.lua');
    new DataRequest(462603, 465515, 0, 0).open('GET', '/interface/game/scoreText.lua');
    new DataRequest(465515, 468898, 0, 0).open('GET', '/interface/intro/introInterface.lua');
    new DataRequest(468898, 470328, 0, 0).open('GET', '/interface/menu/background.lua');
    new DataRequest(470328, 471929, 0, 0).open('GET', '/interface/menu/menuInterface.lua');
    new DataRequest(471929, 472996, 0, 0).open('GET', '/interface/menu/menuText.lua');
    new DataRequest(472996, 473615, 0, 0).open('GET', '/interface/menu/title.lua');
    new DataRequest(473615, 474853, 0, 0).open('GET', '/loop/ingame.lua');
    new DataRequest(474853, 475485, 0, 0).open('GET', '/loop/inintro.lua');
    new DataRequest(475485, 476153, 0, 0).open('GET', '/loop/inmenu.lua');
    new DataRequest(476153, 478174, 0, 0).open('GET', '/loop/thread.lua');
    new DataRequest(478174, 479274, 0, 0).open('GET', '/math/area.lua');
    new DataRequest(479274, 480860, 0, 0).open('GET', '/math/rectangle.lua');
    new DataRequest(480860, 481055, 0, 0).open('GET', '/math/util.lua');
    new DataRequest(481055, 481564, 0, 0).open('GET', '/math/vector.lua');
    new DataRequest(481564, 490935, 0, 0).open('GET', '/menu/data.lua');
    new DataRequest(490935, 491560, 0, 0).open('GET', '/menu/languageArray.lua');
    new DataRequest(491560, 494429, 0, 0).open('GET', '/player/data.lua');
    new DataRequest(494429, 495259, 0, 0).open('GET', '/player/level.lua');
    new DataRequest(495259, 496022, 0, 0).open('GET', '/scenario/scenario.lua');
    new DataRequest(496022, 497517, 0, 0).open('GET', '/scenario/stage1.lua');
    new DataRequest(497517, 497754, 0, 0).open('GET', '/ship/enemies.lua');
    new DataRequest(497754, 500591, 0, 0).open('GET', '/ship/enemyType1.lua');
    new DataRequest(500591, 502841, 0, 0).open('GET', '/ship/enemyType2.lua');
    new DataRequest(502841, 505648, 0, 0).open('GET', '/ship/enemyType3.lua');
    new DataRequest(505648, 509645, 0, 0).open('GET', '/ship/enemyType4.lua');
    new DataRequest(509645, 512679, 0, 0).open('GET', '/ship/enemyType5.lua');
    new DataRequest(512679, 516973, 0, 0).open('GET', '/ship/player.lua');
    new DataRequest(516973, 526051, 0, 0).open('GET', '/ship/ship.lua');
    new DataRequest(526051, 528321, 0, 0).open('GET', '/shot/shot.lua');
    new DataRequest(528321, 528972, 0, 0).open('GET', '/shot/shotLaserBlue.lua');
    new DataRequest(528972, 529623, 0, 0).open('GET', '/shot/shotLaserCyan.lua');
    new DataRequest(529623, 530281, 0, 0).open('GET', '/shot/shotLaserGreen.lua');
    new DataRequest(530281, 530953, 0, 0).open('GET', '/shot/shotLaserMagenta.lua');
    new DataRequest(530953, 531597, 0, 0).open('GET', '/shot/shotLaserRed.lua');
    new DataRequest(531597, 532158, 0, 0).open('GET', '/shot/shotStar.lua');
    new DataRequest(532158, 532856, 0, 0).open('GET', '/spawn/shipClass.lua');
    new DataRequest(532856, 540787, 0, 0).open('GET', '/spawn/spawner.lua');
    new DataRequest(540787, 711551, 0, 0).open('GET', '/texture/background/menuBackground.jpg');
    new DataRequest(711551, 856995, 0, 0).open('GET', '/texture/background/menuBackgroundGlow.jpg');
    new DataRequest(856995, 857124, 0, 0).open('GET', '/texture/effect/blackscreen.png');
    new DataRequest(857124, 869975, 0, 0).open('GET', '/texture/effect/borderhp.png');
    new DataRequest(869975, 1868099, 0, 0).open('GET', '/texture/effect/expType1.png');
    new DataRequest(1868099, 2258189, 0, 0).open('GET', '/texture/effect/expType2.png');
    new DataRequest(2258189, 2268846, 0, 0).open('GET', '/texture/effect/muzzleflash.png');
    new DataRequest(2268846, 2274315, 0, 0).open('GET', '/texture/effect/muzzleflashCyan.png');
    new DataRequest(2274315, 2281217, 0, 0).open('GET', '/texture/effect/muzzleflashRed.png');
    new DataRequest(2281217, 2281344, 0, 0).open('GET', '/texture/effect/whitescreen.png');
    new DataRequest(2281344, 2330300, 0, 0).open('GET', '/texture/logo/lua.png');
    new DataRequest(2330300, 2379150, 0, 0).open('GET', '/texture/logo/moai.png');
    new DataRequest(2379150, 2686113, 0, 0).open('GET', '/texture/logo/title.png');
    new DataRequest(2686113, 2709438, 0, 0).open('GET', '/texture/others/buttonDown.png');
    new DataRequest(2709438, 2732823, 0, 0).open('GET', '/texture/others/buttonRight.png');
    new DataRequest(2732823, 2756984, 0, 0).open('GET', '/texture/others/buttonShoot.png');
    new DataRequest(2756984, 2780316, 0, 0).open('GET', '/texture/others/buttonUp.png');
    new DataRequest(2780316, 2807675, 0, 0).open('GET', '/texture/scenario/bigStars.png');
    new DataRequest(2807675, 3346166, 0, 0).open('GET', '/texture/scenario/littleStars.png');
    new DataRequest(3346166, 3364890, 0, 0).open('GET', '/texture/ship/ship10.png');
    new DataRequest(3364890, 3385917, 0, 0).open('GET', '/texture/ship/ship10dmg.png');
    new DataRequest(3385917, 3399927, 0, 0).open('GET', '/texture/ship/ship5.png');
    new DataRequest(3399927, 3413377, 0, 0).open('GET', '/texture/ship/ship5dmg.png');
    new DataRequest(3413377, 3435807, 0, 0).open('GET', '/texture/ship/ship5life.png');
    new DataRequest(3435807, 3454019, 0, 0).open('GET', '/texture/ship/ship6.png');
    new DataRequest(3454019, 3471455, 0, 0).open('GET', '/texture/ship/ship6dmg.png');
    new DataRequest(3471455, 3486139, 0, 0).open('GET', '/texture/ship/ship7.png');
    new DataRequest(3486139, 3500312, 0, 0).open('GET', '/texture/ship/ship7dmg.png');
    new DataRequest(3500312, 3517498, 0, 0).open('GET', '/texture/ship/ship8.png');
    new DataRequest(3517498, 3535276, 0, 0).open('GET', '/texture/ship/ship8dmg.png');
    new DataRequest(3535276, 3553521, 0, 0).open('GET', '/texture/ship/ship9.png');
    new DataRequest(3553521, 3571000, 0, 0).open('GET', '/texture/ship/ship9dmg.png');
    new DataRequest(3571000, 3576425, 0, 0).open('GET', '/texture/shot/laserblue.png');
    new DataRequest(3576425, 3581808, 0, 0).open('GET', '/texture/shot/lasercyan.png');
    new DataRequest(3581808, 3587247, 0, 0).open('GET', '/texture/shot/lasergreen.png');
    new DataRequest(3587247, 3592488, 0, 0).open('GET', '/texture/shot/lasermagenta.png');
    new DataRequest(3592488, 3597814, 0, 0).open('GET', '/texture/shot/laserred.png');
    new DataRequest(3597814, 3613498, 0, 0).open('GET', '/texture/shot/starshot.png');
    new DataRequest(3613498, 3616425, 0, 0).open('GET', '/texture/shot/low/lasergreen.png');
    new DataRequest(3616425, 3621170, 0, 0).open('GET', '/window/window.lua');

    if (!Module.expectedDataFileDownloads) {
      Module.expectedDataFileDownloads = 0;
      Module.finishedDataFileDownloads = 0;
    }
    Module.expectedDataFileDownloads++;

    var PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    var PACKAGE_NAME = 'D:/Git/Swift-Space-Battle/distribute/html/html-release/www/moaiapp.rom';
    var REMOTE_PACKAGE_NAME = 'moaiapp.rom';
    var PACKAGE_UUID = '726b6975-aadd-4502-9b16-bc94ce1e9681';
  
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
          DataRequest.prototype.requests["/effect/blackscreen.lua"].onload();
          DataRequest.prototype.requests["/effect/blend.lua"].onload();
          DataRequest.prototype.requests["/effect/blink.lua"].onload();
          DataRequest.prototype.requests["/effect/explosion.lua"].onload();
          DataRequest.prototype.requests["/effect/spawnblink.lua"].onload();
          DataRequest.prototype.requests["/file/button.lua"].onload();
          DataRequest.prototype.requests["/file/resolutions.lua"].onload();
          DataRequest.prototype.requests["/file/saveLocation.lua"].onload();
          DataRequest.prototype.requests["/file/strings.lua"].onload();
          DataRequest.prototype.requests["/file/language/cs.lua"].onload();
          DataRequest.prototype.requests["/file/language/da.lua"].onload();
          DataRequest.prototype.requests["/file/language/de.lua"].onload();
          DataRequest.prototype.requests["/file/language/el.lua"].onload();
          DataRequest.prototype.requests["/file/language/en.lua"].onload();
          DataRequest.prototype.requests["/file/language/es.lua"].onload();
          DataRequest.prototype.requests["/file/language/fr.lua"].onload();
          DataRequest.prototype.requests["/file/language/hu.lua"].onload();
          DataRequest.prototype.requests["/file/language/id.lua"].onload();
          DataRequest.prototype.requests["/file/language/it.lua"].onload();
          DataRequest.prototype.requests["/file/language/nb.lua"].onload();
          DataRequest.prototype.requests["/file/language/nl.lua"].onload();
          DataRequest.prototype.requests["/file/language/pt.lua"].onload();
          DataRequest.prototype.requests["/file/language/ru.lua"].onload();
          DataRequest.prototype.requests["/file/language/sv.lua"].onload();
          DataRequest.prototype.requests["/file/language/uk.lua"].onload();
          DataRequest.prototype.requests["/font/LICENSE-NotoSans-Regular.txt"].onload();
          DataRequest.prototype.requests["/font/NotoSans-Regular.ttf"].onload();
          DataRequest.prototype.requests["/input/input.lua"].onload();
          DataRequest.prototype.requests["/input/keyboard.lua"].onload();
          DataRequest.prototype.requests["/input/mouse.lua"].onload();
          DataRequest.prototype.requests["/input/touch.lua"].onload();
          DataRequest.prototype.requests["/interface/priority.lua"].onload();
          DataRequest.prototype.requests["/interface/game/borderHp.lua"].onload();
          DataRequest.prototype.requests["/interface/game/buttons.lua"].onload();
          DataRequest.prototype.requests["/interface/game/gameInterface.lua"].onload();
          DataRequest.prototype.requests["/interface/game/gameOver.lua"].onload();
          DataRequest.prototype.requests["/interface/game/gameText.lua"].onload();
          DataRequest.prototype.requests["/interface/game/lives.lua"].onload();
          DataRequest.prototype.requests["/interface/game/scoreText.lua"].onload();
          DataRequest.prototype.requests["/interface/intro/introInterface.lua"].onload();
          DataRequest.prototype.requests["/interface/menu/background.lua"].onload();
          DataRequest.prototype.requests["/interface/menu/menuInterface.lua"].onload();
          DataRequest.prototype.requests["/interface/menu/menuText.lua"].onload();
          DataRequest.prototype.requests["/interface/menu/title.lua"].onload();
          DataRequest.prototype.requests["/loop/ingame.lua"].onload();
          DataRequest.prototype.requests["/loop/inintro.lua"].onload();
          DataRequest.prototype.requests["/loop/inmenu.lua"].onload();
          DataRequest.prototype.requests["/loop/thread.lua"].onload();
          DataRequest.prototype.requests["/math/area.lua"].onload();
          DataRequest.prototype.requests["/math/rectangle.lua"].onload();
          DataRequest.prototype.requests["/math/util.lua"].onload();
          DataRequest.prototype.requests["/math/vector.lua"].onload();
          DataRequest.prototype.requests["/menu/data.lua"].onload();
          DataRequest.prototype.requests["/menu/languageArray.lua"].onload();
          DataRequest.prototype.requests["/player/data.lua"].onload();
          DataRequest.prototype.requests["/player/level.lua"].onload();
          DataRequest.prototype.requests["/scenario/scenario.lua"].onload();
          DataRequest.prototype.requests["/scenario/stage1.lua"].onload();
          DataRequest.prototype.requests["/ship/enemies.lua"].onload();
          DataRequest.prototype.requests["/ship/enemyType1.lua"].onload();
          DataRequest.prototype.requests["/ship/enemyType2.lua"].onload();
          DataRequest.prototype.requests["/ship/enemyType3.lua"].onload();
          DataRequest.prototype.requests["/ship/enemyType4.lua"].onload();
          DataRequest.prototype.requests["/ship/enemyType5.lua"].onload();
          DataRequest.prototype.requests["/ship/player.lua"].onload();
          DataRequest.prototype.requests["/ship/ship.lua"].onload();
          DataRequest.prototype.requests["/shot/shot.lua"].onload();
          DataRequest.prototype.requests["/shot/shotLaserBlue.lua"].onload();
          DataRequest.prototype.requests["/shot/shotLaserCyan.lua"].onload();
          DataRequest.prototype.requests["/shot/shotLaserGreen.lua"].onload();
          DataRequest.prototype.requests["/shot/shotLaserMagenta.lua"].onload();
          DataRequest.prototype.requests["/shot/shotLaserRed.lua"].onload();
          DataRequest.prototype.requests["/shot/shotStar.lua"].onload();
          DataRequest.prototype.requests["/spawn/shipClass.lua"].onload();
          DataRequest.prototype.requests["/spawn/spawner.lua"].onload();
          DataRequest.prototype.requests["/texture/background/menuBackground.jpg"].onload();
          DataRequest.prototype.requests["/texture/background/menuBackgroundGlow.jpg"].onload();
          DataRequest.prototype.requests["/texture/effect/blackscreen.png"].onload();
          DataRequest.prototype.requests["/texture/effect/borderhp.png"].onload();
          DataRequest.prototype.requests["/texture/effect/expType1.png"].onload();
          DataRequest.prototype.requests["/texture/effect/expType2.png"].onload();
          DataRequest.prototype.requests["/texture/effect/muzzleflash.png"].onload();
          DataRequest.prototype.requests["/texture/effect/muzzleflashCyan.png"].onload();
          DataRequest.prototype.requests["/texture/effect/muzzleflashRed.png"].onload();
          DataRequest.prototype.requests["/texture/effect/whitescreen.png"].onload();
          DataRequest.prototype.requests["/texture/logo/lua.png"].onload();
          DataRequest.prototype.requests["/texture/logo/moai.png"].onload();
          DataRequest.prototype.requests["/texture/logo/title.png"].onload();
          DataRequest.prototype.requests["/texture/others/buttonDown.png"].onload();
          DataRequest.prototype.requests["/texture/others/buttonRight.png"].onload();
          DataRequest.prototype.requests["/texture/others/buttonShoot.png"].onload();
          DataRequest.prototype.requests["/texture/others/buttonUp.png"].onload();
          DataRequest.prototype.requests["/texture/scenario/bigStars.png"].onload();
          DataRequest.prototype.requests["/texture/scenario/littleStars.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship10.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship10dmg.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship5.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship5dmg.png"].onload();
          DataRequest.prototype.requests["/texture/ship/ship5life.png"].onload();
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
          DataRequest.prototype.requests["/window/window.lua"].onload();
          Module['removeRunDependency']('datafile_D:/Git/Swift-Space-Battle/distribute/html/html-release/www/moaiapp.rom');

    };
    Module['addRunDependency']('datafile_D:/Git/Swift-Space-Battle/distribute/html/html-release/www/moaiapp.rom');
  
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
