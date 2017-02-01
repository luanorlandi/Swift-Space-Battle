
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
Module['FS_createPath']('/', 'src', true, true);
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
    new DataRequest(1067, 2191, 0, 0).open('GET', '/run.bat');
    new DataRequest(2191, 2842, 0, 0).open('GET', '/effect/blackscreen.lua');
    new DataRequest(2842, 3591, 0, 0).open('GET', '/effect/blend.lua');
    new DataRequest(3591, 3868, 0, 0).open('GET', '/effect/blink.lua');
    new DataRequest(3868, 5659, 0, 0).open('GET', '/effect/explosion.lua');
    new DataRequest(5659, 6306, 0, 0).open('GET', '/effect/spawnblink.lua');
    new DataRequest(6306, 6824, 0, 0).open('GET', '/file/en.lua');
    new DataRequest(6824, 7379, 0, 0).open('GET', '/file/pt.lua');
    new DataRequest(7379, 7438, 0, 0).open('GET', '/file/resolutions.lua');
    new DataRequest(7438, 8040, 0, 0).open('GET', '/file/saveLocation.lua');
    new DataRequest(8040, 9180, 0, 0).open('GET', '/file/strings.lua');
    new DataRequest(9180, 100920, 0, 0).open('GET', '/font/recharge bd.ttf');
    new DataRequest(100920, 127176, 0, 0).open('GET', '/font/RosesareFF0000.ttf');
    new DataRequest(127176, 127345, 0, 0).open('GET', '/font/source.txt');
    new DataRequest(127345, 148701, 0, 0).open('GET', '/font/zekton free.ttf');
    new DataRequest(148701, 149743, 0, 0).open('GET', '/input/input.lua');
    new DataRequest(149743, 150651, 0, 0).open('GET', '/input/keyboard.lua');
    new DataRequest(150651, 151388, 0, 0).open('GET', '/input/mouse.lua');
    new DataRequest(151388, 154086, 0, 0).open('GET', '/input/touch.lua');
    new DataRequest(154086, 154286, 0, 0).open('GET', '/interface/priority.lua');
    new DataRequest(154286, 155399, 0, 0).open('GET', '/interface/game/borderHp.lua');
    new DataRequest(155399, 159881, 0, 0).open('GET', '/interface/game/buttons.lua');
    new DataRequest(159881, 162041, 0, 0).open('GET', '/interface/game/gameInterface.lua');
    new DataRequest(162041, 165749, 0, 0).open('GET', '/interface/game/gameOver.lua');
    new DataRequest(165749, 166370, 0, 0).open('GET', '/interface/game/gameText.lua');
    new DataRequest(166370, 167498, 0, 0).open('GET', '/interface/game/lives.lua');
    new DataRequest(167498, 170439, 0, 0).open('GET', '/interface/game/scoreText.lua');
    new DataRequest(170439, 173699, 0, 0).open('GET', '/interface/intro/introInterface.lua');
    new DataRequest(173699, 175082, 0, 0).open('GET', '/interface/menu/background.lua');
    new DataRequest(175082, 176639, 0, 0).open('GET', '/interface/menu/menuInterface.lua');
    new DataRequest(176639, 177875, 0, 0).open('GET', '/interface/menu/menuText.lua');
    new DataRequest(177875, 178468, 0, 0).open('GET', '/interface/menu/title.lua');
    new DataRequest(178468, 179637, 0, 0).open('GET', '/loop/ingame.lua');
    new DataRequest(179637, 180242, 0, 0).open('GET', '/loop/inintro.lua');
    new DataRequest(180242, 180879, 0, 0).open('GET', '/loop/inmenu.lua');
    new DataRequest(180879, 182808, 0, 0).open('GET', '/loop/thread.lua');
    new DataRequest(182808, 183861, 0, 0).open('GET', '/math/area.lua');
    new DataRequest(183861, 185385, 0, 0).open('GET', '/math/rectangle.lua');
    new DataRequest(185385, 185571, 0, 0).open('GET', '/math/util.lua');
    new DataRequest(185571, 186047, 0, 0).open('GET', '/math/vector.lua');
    new DataRequest(186047, 194081, 0, 0).open('GET', '/menu/data.lua');
    new DataRequest(194081, 196791, 0, 0).open('GET', '/player/data.lua');
    new DataRequest(196791, 197575, 0, 0).open('GET', '/player/level.lua');
    new DataRequest(197575, 198301, 0, 0).open('GET', '/scenario/scenario.lua');
    new DataRequest(198301, 199742, 0, 0).open('GET', '/scenario/stage1.lua');
    new DataRequest(199742, 199965, 0, 0).open('GET', '/ship/enemies.lua');
    new DataRequest(199965, 202698, 0, 0).open('GET', '/ship/enemyType1.lua');
    new DataRequest(202698, 204865, 0, 0).open('GET', '/ship/enemyType2.lua');
    new DataRequest(204865, 207563, 0, 0).open('GET', '/ship/enemyType3.lua');
    new DataRequest(207563, 211406, 0, 0).open('GET', '/ship/enemyType4.lua');
    new DataRequest(211406, 214340, 0, 0).open('GET', '/ship/enemyType5.lua');
    new DataRequest(214340, 218470, 0, 0).open('GET', '/ship/player.lua');
    new DataRequest(218470, 227170, 0, 0).open('GET', '/ship/ship.lua');
    new DataRequest(227170, 229325, 0, 0).open('GET', '/shot/shot.lua');
    new DataRequest(229325, 229952, 0, 0).open('GET', '/shot/shotLaserBlue.lua');
    new DataRequest(229952, 230579, 0, 0).open('GET', '/shot/shotLaserCyan.lua');
    new DataRequest(230579, 231213, 0, 0).open('GET', '/shot/shotLaserGreen.lua');
    new DataRequest(231213, 231861, 0, 0).open('GET', '/shot/shotLaserMagenta.lua');
    new DataRequest(231861, 232481, 0, 0).open('GET', '/shot/shotLaserRed.lua');
    new DataRequest(232481, 233018, 0, 0).open('GET', '/shot/shotStar.lua');
    new DataRequest(233018, 233683, 0, 0).open('GET', '/spawn/shipClass.lua');
    new DataRequest(233683, 241286, 0, 0).open('GET', '/spawn/spawner.lua');
    new DataRequest(241286, 241339, 0, 0).open('GET', '/src/run.bat');
    new DataRequest(241339, 412103, 0, 0).open('GET', '/texture/background/menuBackground.jpg');
    new DataRequest(412103, 557547, 0, 0).open('GET', '/texture/background/menuBackgroundGlow.jpg');
    new DataRequest(557547, 557676, 0, 0).open('GET', '/texture/effect/blackscreen.png');
    new DataRequest(557676, 570527, 0, 0).open('GET', '/texture/effect/borderhp.png');
    new DataRequest(570527, 1568651, 0, 0).open('GET', '/texture/effect/expType1.png');
    new DataRequest(1568651, 1958741, 0, 0).open('GET', '/texture/effect/expType2.png');
    new DataRequest(1958741, 1969398, 0, 0).open('GET', '/texture/effect/muzzleflash.png');
    new DataRequest(1969398, 1974867, 0, 0).open('GET', '/texture/effect/muzzleflashCyan.png');
    new DataRequest(1974867, 1981769, 0, 0).open('GET', '/texture/effect/muzzleflashRed.png');
    new DataRequest(1981769, 1981896, 0, 0).open('GET', '/texture/effect/whitescreen.png');
    new DataRequest(1981896, 2030852, 0, 0).open('GET', '/texture/logo/lua.png');
    new DataRequest(2030852, 2079702, 0, 0).open('GET', '/texture/logo/moai.png');
    new DataRequest(2079702, 2386665, 0, 0).open('GET', '/texture/logo/title.png');
    new DataRequest(2386665, 2409990, 0, 0).open('GET', '/texture/others/buttonDown.png');
    new DataRequest(2409990, 2433375, 0, 0).open('GET', '/texture/others/buttonRight.png');
    new DataRequest(2433375, 2457536, 0, 0).open('GET', '/texture/others/buttonShoot.png');
    new DataRequest(2457536, 2480868, 0, 0).open('GET', '/texture/others/buttonUp.png');
    new DataRequest(2480868, 2508227, 0, 0).open('GET', '/texture/scenario/bigStars.png');
    new DataRequest(2508227, 3046718, 0, 0).open('GET', '/texture/scenario/littleStars.png');
    new DataRequest(3046718, 3065442, 0, 0).open('GET', '/texture/ship/ship10.png');
    new DataRequest(3065442, 3086469, 0, 0).open('GET', '/texture/ship/ship10dmg.png');
    new DataRequest(3086469, 3100479, 0, 0).open('GET', '/texture/ship/ship5.png');
    new DataRequest(3100479, 3113929, 0, 0).open('GET', '/texture/ship/ship5dmg.png');
    new DataRequest(3113929, 3136359, 0, 0).open('GET', '/texture/ship/ship5life.png');
    new DataRequest(3136359, 3154571, 0, 0).open('GET', '/texture/ship/ship6.png');
    new DataRequest(3154571, 3172007, 0, 0).open('GET', '/texture/ship/ship6dmg.png');
    new DataRequest(3172007, 3186691, 0, 0).open('GET', '/texture/ship/ship7.png');
    new DataRequest(3186691, 3200864, 0, 0).open('GET', '/texture/ship/ship7dmg.png');
    new DataRequest(3200864, 3218050, 0, 0).open('GET', '/texture/ship/ship8.png');
    new DataRequest(3218050, 3235828, 0, 0).open('GET', '/texture/ship/ship8dmg.png');
    new DataRequest(3235828, 3254073, 0, 0).open('GET', '/texture/ship/ship9.png');
    new DataRequest(3254073, 3271552, 0, 0).open('GET', '/texture/ship/ship9dmg.png');
    new DataRequest(3271552, 3276977, 0, 0).open('GET', '/texture/shot/laserblue.png');
    new DataRequest(3276977, 3282360, 0, 0).open('GET', '/texture/shot/lasercyan.png');
    new DataRequest(3282360, 3287799, 0, 0).open('GET', '/texture/shot/lasergreen.png');
    new DataRequest(3287799, 3293040, 0, 0).open('GET', '/texture/shot/lasermagenta.png');
    new DataRequest(3293040, 3298366, 0, 0).open('GET', '/texture/shot/laserred.png');
    new DataRequest(3298366, 3314050, 0, 0).open('GET', '/texture/shot/starshot.png');
    new DataRequest(3314050, 3316977, 0, 0).open('GET', '/texture/shot/low/lasergreen.png');
    new DataRequest(3316977, 3321560, 0, 0).open('GET', '/window/window.lua');

    if (!Module.expectedDataFileDownloads) {
      Module.expectedDataFileDownloads = 0;
      Module.finishedDataFileDownloads = 0;
    }
    Module.expectedDataFileDownloads++;

    var PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    var PACKAGE_NAME = 'C:/Users/Orlandi/Documents/Git/Swift-Space-Battle/distribute/html/html-debug/www/moaiapp.rom';
    var REMOTE_PACKAGE_NAME = 'moaiapp.rom';
    var PACKAGE_UUID = '583f27b4-e4f0-4551-ab44-823aa9bc3762';
  
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
          DataRequest.prototype.requests["/src/run.bat"].onload();
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
          Module['removeRunDependency']('datafile_C:/Users/Orlandi/Documents/Git/Swift-Space-Battle/distribute/html/html-debug/www/moaiapp.rom');

    };
    Module['addRunDependency']('datafile_C:/Users/Orlandi/Documents/Git/Swift-Space-Battle/distribute/html/html-debug/www/moaiapp.rom');
  
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
