
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
      new DataRequest(0, 1067, 0, 0).open('GET', '/main.lua');
    new DataRequest(1067, 1122, 0, 0).open('GET', '/run.bat');
    new DataRequest(1122, 1773, 0, 0).open('GET', '/effect/blackscreen.lua');
    new DataRequest(1773, 2522, 0, 0).open('GET', '/effect/blend.lua');
    new DataRequest(2522, 2799, 0, 0).open('GET', '/effect/blink.lua');
    new DataRequest(2799, 4590, 0, 0).open('GET', '/effect/explosion.lua');
    new DataRequest(4590, 5237, 0, 0).open('GET', '/effect/spawnblink.lua');
    new DataRequest(5237, 5755, 0, 0).open('GET', '/file/en.lua');
    new DataRequest(5755, 6310, 0, 0).open('GET', '/file/pt.lua');
    new DataRequest(6310, 6369, 0, 0).open('GET', '/file/resolutions.lua');
    new DataRequest(6369, 6971, 0, 0).open('GET', '/file/saveLocation.lua');
    new DataRequest(6971, 8111, 0, 0).open('GET', '/file/strings.lua');
    new DataRequest(8111, 99851, 0, 0).open('GET', '/font/recharge bd.ttf');
    new DataRequest(99851, 126107, 0, 0).open('GET', '/font/RosesareFF0000.ttf');
    new DataRequest(126107, 126276, 0, 0).open('GET', '/font/source.txt');
    new DataRequest(126276, 147632, 0, 0).open('GET', '/font/zekton free.ttf');
    new DataRequest(147632, 148674, 0, 0).open('GET', '/input/input.lua');
    new DataRequest(148674, 149582, 0, 0).open('GET', '/input/keyboard.lua');
    new DataRequest(149582, 150319, 0, 0).open('GET', '/input/mouse.lua');
    new DataRequest(150319, 153017, 0, 0).open('GET', '/input/touch.lua');
    new DataRequest(153017, 153217, 0, 0).open('GET', '/interface/priority.lua');
    new DataRequest(153217, 154330, 0, 0).open('GET', '/interface/game/borderHp.lua');
    new DataRequest(154330, 158812, 0, 0).open('GET', '/interface/game/buttons.lua');
    new DataRequest(158812, 160972, 0, 0).open('GET', '/interface/game/gameInterface.lua');
    new DataRequest(160972, 164680, 0, 0).open('GET', '/interface/game/gameOver.lua');
    new DataRequest(164680, 165301, 0, 0).open('GET', '/interface/game/gameText.lua');
    new DataRequest(165301, 166429, 0, 0).open('GET', '/interface/game/lives.lua');
    new DataRequest(166429, 169370, 0, 0).open('GET', '/interface/game/scoreText.lua');
    new DataRequest(169370, 172630, 0, 0).open('GET', '/interface/intro/introInterface.lua');
    new DataRequest(172630, 174013, 0, 0).open('GET', '/interface/menu/background.lua');
    new DataRequest(174013, 175570, 0, 0).open('GET', '/interface/menu/menuInterface.lua');
    new DataRequest(175570, 176806, 0, 0).open('GET', '/interface/menu/menuText.lua');
    new DataRequest(176806, 177399, 0, 0).open('GET', '/interface/menu/title.lua');
    new DataRequest(177399, 178568, 0, 0).open('GET', '/loop/ingame.lua');
    new DataRequest(178568, 179173, 0, 0).open('GET', '/loop/inintro.lua');
    new DataRequest(179173, 179810, 0, 0).open('GET', '/loop/inmenu.lua');
    new DataRequest(179810, 181739, 0, 0).open('GET', '/loop/thread.lua');
    new DataRequest(181739, 182792, 0, 0).open('GET', '/math/area.lua');
    new DataRequest(182792, 184316, 0, 0).open('GET', '/math/rectangle.lua');
    new DataRequest(184316, 184502, 0, 0).open('GET', '/math/util.lua');
    new DataRequest(184502, 184978, 0, 0).open('GET', '/math/vector.lua');
    new DataRequest(184978, 193005, 0, 0).open('GET', '/menu/data.lua');
    new DataRequest(193005, 195715, 0, 0).open('GET', '/player/data.lua');
    new DataRequest(195715, 196499, 0, 0).open('GET', '/player/level.lua');
    new DataRequest(196499, 197225, 0, 0).open('GET', '/scenario/scenario.lua');
    new DataRequest(197225, 198666, 0, 0).open('GET', '/scenario/stage1.lua');
    new DataRequest(198666, 198889, 0, 0).open('GET', '/ship/enemies.lua');
    new DataRequest(198889, 201622, 0, 0).open('GET', '/ship/enemyType1.lua');
    new DataRequest(201622, 203789, 0, 0).open('GET', '/ship/enemyType2.lua');
    new DataRequest(203789, 206487, 0, 0).open('GET', '/ship/enemyType3.lua');
    new DataRequest(206487, 210330, 0, 0).open('GET', '/ship/enemyType4.lua');
    new DataRequest(210330, 213264, 0, 0).open('GET', '/ship/enemyType5.lua');
    new DataRequest(213264, 217394, 0, 0).open('GET', '/ship/player.lua');
    new DataRequest(217394, 226094, 0, 0).open('GET', '/ship/ship.lua');
    new DataRequest(226094, 228249, 0, 0).open('GET', '/shot/shot.lua');
    new DataRequest(228249, 228876, 0, 0).open('GET', '/shot/shotLaserBlue.lua');
    new DataRequest(228876, 229503, 0, 0).open('GET', '/shot/shotLaserCyan.lua');
    new DataRequest(229503, 230137, 0, 0).open('GET', '/shot/shotLaserGreen.lua');
    new DataRequest(230137, 230785, 0, 0).open('GET', '/shot/shotLaserMagenta.lua');
    new DataRequest(230785, 231405, 0, 0).open('GET', '/shot/shotLaserRed.lua');
    new DataRequest(231405, 231942, 0, 0).open('GET', '/shot/shotStar.lua');
    new DataRequest(231942, 232607, 0, 0).open('GET', '/spawn/shipClass.lua');
    new DataRequest(232607, 240210, 0, 0).open('GET', '/spawn/spawner.lua');
    new DataRequest(240210, 410974, 0, 0).open('GET', '/texture/background/menuBackground.jpg');
    new DataRequest(410974, 556418, 0, 0).open('GET', '/texture/background/menuBackgroundGlow.jpg');
    new DataRequest(556418, 556547, 0, 0).open('GET', '/texture/effect/blackscreen.png');
    new DataRequest(556547, 569398, 0, 0).open('GET', '/texture/effect/borderhp.png');
    new DataRequest(569398, 1567522, 0, 0).open('GET', '/texture/effect/expType1.png');
    new DataRequest(1567522, 1957612, 0, 0).open('GET', '/texture/effect/expType2.png');
    new DataRequest(1957612, 1968269, 0, 0).open('GET', '/texture/effect/muzzleflash.png');
    new DataRequest(1968269, 1973738, 0, 0).open('GET', '/texture/effect/muzzleflashCyan.png');
    new DataRequest(1973738, 1980640, 0, 0).open('GET', '/texture/effect/muzzleflashRed.png');
    new DataRequest(1980640, 1980767, 0, 0).open('GET', '/texture/effect/whitescreen.png');
    new DataRequest(1980767, 2029723, 0, 0).open('GET', '/texture/logo/lua.png');
    new DataRequest(2029723, 2078573, 0, 0).open('GET', '/texture/logo/moai.png');
    new DataRequest(2078573, 2385536, 0, 0).open('GET', '/texture/logo/title.png');
    new DataRequest(2385536, 2408861, 0, 0).open('GET', '/texture/others/buttonDown.png');
    new DataRequest(2408861, 2432246, 0, 0).open('GET', '/texture/others/buttonRight.png');
    new DataRequest(2432246, 2456407, 0, 0).open('GET', '/texture/others/buttonShoot.png');
    new DataRequest(2456407, 2479739, 0, 0).open('GET', '/texture/others/buttonUp.png');
    new DataRequest(2479739, 2507098, 0, 0).open('GET', '/texture/scenario/bigStars.png');
    new DataRequest(2507098, 3045589, 0, 0).open('GET', '/texture/scenario/littleStars.png');
    new DataRequest(3045589, 3064313, 0, 0).open('GET', '/texture/ship/ship10.png');
    new DataRequest(3064313, 3085340, 0, 0).open('GET', '/texture/ship/ship10dmg.png');
    new DataRequest(3085340, 3099350, 0, 0).open('GET', '/texture/ship/ship5.png');
    new DataRequest(3099350, 3112800, 0, 0).open('GET', '/texture/ship/ship5dmg.png');
    new DataRequest(3112800, 3135230, 0, 0).open('GET', '/texture/ship/ship5life.png');
    new DataRequest(3135230, 3153442, 0, 0).open('GET', '/texture/ship/ship6.png');
    new DataRequest(3153442, 3170878, 0, 0).open('GET', '/texture/ship/ship6dmg.png');
    new DataRequest(3170878, 3185562, 0, 0).open('GET', '/texture/ship/ship7.png');
    new DataRequest(3185562, 3199735, 0, 0).open('GET', '/texture/ship/ship7dmg.png');
    new DataRequest(3199735, 3216921, 0, 0).open('GET', '/texture/ship/ship8.png');
    new DataRequest(3216921, 3234699, 0, 0).open('GET', '/texture/ship/ship8dmg.png');
    new DataRequest(3234699, 3252944, 0, 0).open('GET', '/texture/ship/ship9.png');
    new DataRequest(3252944, 3270423, 0, 0).open('GET', '/texture/ship/ship9dmg.png');
    new DataRequest(3270423, 3275848, 0, 0).open('GET', '/texture/shot/laserblue.png');
    new DataRequest(3275848, 3281231, 0, 0).open('GET', '/texture/shot/lasercyan.png');
    new DataRequest(3281231, 3286670, 0, 0).open('GET', '/texture/shot/lasergreen.png');
    new DataRequest(3286670, 3291911, 0, 0).open('GET', '/texture/shot/lasermagenta.png');
    new DataRequest(3291911, 3297237, 0, 0).open('GET', '/texture/shot/laserred.png');
    new DataRequest(3297237, 3312921, 0, 0).open('GET', '/texture/shot/starshot.png');
    new DataRequest(3312921, 3315848, 0, 0).open('GET', '/texture/shot/low/lasergreen.png');
    new DataRequest(3315848, 3320431, 0, 0).open('GET', '/window/window.lua');

    if (!Module.expectedDataFileDownloads) {
      Module.expectedDataFileDownloads = 0;
      Module.finishedDataFileDownloads = 0;
    }
    Module.expectedDataFileDownloads++;

    var PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    var PACKAGE_NAME = 'C:/Users/Orlandi/Documents/Git/Swift-Space-Battle/distribute/html/html-release/www/moaiapp.rom';
    var REMOTE_PACKAGE_NAME = 'moaiapp.rom';
    var PACKAGE_UUID = 'e1ae4197-5cb4-454b-b935-c95f29af8149';
  
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
          DataRequest.prototype.requests["/run.bat"].onload();
          DataRequest.prototype.requests["/effect/blackscreen.lua"].onload();
          DataRequest.prototype.requests["/effect/blend.lua"].onload();
          DataRequest.prototype.requests["/effect/blink.lua"].onload();
          DataRequest.prototype.requests["/effect/explosion.lua"].onload();
          DataRequest.prototype.requests["/effect/spawnblink.lua"].onload();
          DataRequest.prototype.requests["/file/en.lua"].onload();
          DataRequest.prototype.requests["/file/pt.lua"].onload();
          DataRequest.prototype.requests["/file/resolutions.lua"].onload();
          DataRequest.prototype.requests["/file/saveLocation.lua"].onload();
          DataRequest.prototype.requests["/file/strings.lua"].onload();
          DataRequest.prototype.requests["/font/recharge bd.ttf"].onload();
          DataRequest.prototype.requests["/font/RosesareFF0000.ttf"].onload();
          DataRequest.prototype.requests["/font/source.txt"].onload();
          DataRequest.prototype.requests["/font/zekton free.ttf"].onload();
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
          Module['removeRunDependency']('datafile_C:/Users/Orlandi/Documents/Git/Swift-Space-Battle/distribute/html/html-release/www/moaiapp.rom');

    };
    Module['addRunDependency']('datafile_C:/Users/Orlandi/Documents/Git/Swift-Space-Battle/distribute/html/html-release/www/moaiapp.rom');
  
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
