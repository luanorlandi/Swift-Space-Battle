
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
      new DataRequest(0, 1111, 0, 0).open('GET', '/main.lua');
    new DataRequest(1111, 1788, 0, 0).open('GET', '/data/effect/blackscreen.lua');
    new DataRequest(1788, 2575, 0, 0).open('GET', '/data/effect/blend.lua');
    new DataRequest(2575, 2867, 0, 0).open('GET', '/data/effect/blink.lua');
    new DataRequest(2867, 4602, 0, 0).open('GET', '/data/effect/explosion.lua');
    new DataRequest(4602, 5281, 0, 0).open('GET', '/data/effect/spawnblink.lua');
    new DataRequest(5281, 6079, 0, 0).open('GET', '/data/input/input.lua');
    new DataRequest(6079, 6611, 0, 0).open('GET', '/data/input/keyboard.lua');
    new DataRequest(6611, 8077, 0, 0).open('GET', '/data/input/mouse.lua');
    new DataRequest(8077, 9270, 0, 0).open('GET', '/data/input/touch.lua');
    new DataRequest(9270, 9480, 0, 0).open('GET', '/data/interface/priority.lua');
    new DataRequest(9480, 10571, 0, 0).open('GET', '/data/interface/game/borderHp.lua');
    new DataRequest(10571, 12690, 0, 0).open('GET', '/data/interface/game/gameInterface.lua');
    new DataRequest(12690, 16634, 0, 0).open('GET', '/data/interface/game/gameOver.lua');
    new DataRequest(16634, 17267, 0, 0).open('GET', '/data/interface/game/gameText.lua');
    new DataRequest(17267, 18476, 0, 0).open('GET', '/data/interface/game/lives.lua');
    new DataRequest(18476, 21571, 0, 0).open('GET', '/data/interface/game/scoreText.lua');
    new DataRequest(21571, 24923, 0, 0).open('GET', '/data/interface/intro/introInterface.lua');
    new DataRequest(24923, 25462, 0, 0).open('GET', '/data/interface/menu/background.lua');
    new DataRequest(25462, 27756, 0, 0).open('GET', '/data/interface/menu/menuInterface.lua');
    new DataRequest(27756, 29024, 0, 0).open('GET', '/data/interface/menu/menuText.lua');
    new DataRequest(29024, 29547, 0, 0).open('GET', '/data/interface/menu/title.lua');
    new DataRequest(29547, 30615, 0, 0).open('GET', '/data/loop/ingame.lua');
    new DataRequest(30615, 30981, 0, 0).open('GET', '/data/loop/inintro.lua');
    new DataRequest(30981, 31294, 0, 0).open('GET', '/data/loop/inmenu.lua');
    new DataRequest(31294, 33496, 0, 0).open('GET', '/data/loop/thread.lua');
    new DataRequest(33496, 34629, 0, 0).open('GET', '/data/math/area.lua');
    new DataRequest(34629, 36235, 0, 0).open('GET', '/data/math/rectangle.lua');
    new DataRequest(36235, 36436, 0, 0).open('GET', '/data/math/util.lua');
    new DataRequest(36436, 36945, 0, 0).open('GET', '/data/math/vector.lua');
    new DataRequest(36945, 42887, 0, 0).open('GET', '/data/menu/data.lua');
    new DataRequest(42887, 45158, 0, 0).open('GET', '/data/player/data.lua');
    new DataRequest(45158, 45996, 0, 0).open('GET', '/data/player/level.lua');
    new DataRequest(45996, 46745, 0, 0).open('GET', '/data/scenario/scenario.lua');
    new DataRequest(46745, 48267, 0, 0).open('GET', '/data/scenario/stage1.lua');
    new DataRequest(48267, 51362, 0, 0).open('GET', '/data/screen/screen.lua');
    new DataRequest(51362, 51599, 0, 0).open('GET', '/data/ship/enemies.lua');
    new DataRequest(51599, 54451, 0, 0).open('GET', '/data/ship/enemyType1.lua');
    new DataRequest(54451, 56712, 0, 0).open('GET', '/data/ship/enemyType2.lua');
    new DataRequest(56712, 59521, 0, 0).open('GET', '/data/ship/enemyType3.lua');
    new DataRequest(59521, 63544, 0, 0).open('GET', '/data/ship/enemyType4.lua');
    new DataRequest(63544, 66580, 0, 0).open('GET', '/data/ship/enemyType5.lua');
    new DataRequest(66580, 69475, 0, 0).open('GET', '/data/ship/player.lua');
    new DataRequest(69475, 79077, 0, 0).open('GET', '/data/ship/ship.lua');
    new DataRequest(79077, 81400, 0, 0).open('GET', '/data/shot/shot.lua');
    new DataRequest(81400, 82051, 0, 0).open('GET', '/data/shot/shotLaserBlue.lua');
    new DataRequest(82051, 82702, 0, 0).open('GET', '/data/shot/shotLaserCyan.lua');
    new DataRequest(82702, 83360, 0, 0).open('GET', '/data/shot/shotLaserGreen.lua');
    new DataRequest(83360, 84032, 0, 0).open('GET', '/data/shot/shotLaserMagenta.lua');
    new DataRequest(84032, 84676, 0, 0).open('GET', '/data/shot/shotLaserRed.lua');
    new DataRequest(84676, 85237, 0, 0).open('GET', '/data/shot/shotStar.lua');
    new DataRequest(85237, 85919, 0, 0).open('GET', '/data/spawn/shipClass.lua');
    new DataRequest(85919, 93883, 0, 0).open('GET', '/data/spawn/spawner.lua');
    new DataRequest(93883, 93955, 0, 0).open('GET', '/file/listOfResolutions.lua');
    new DataRequest(93955, 93956, 0, 0).open('GET', '/file/options.lua');
    new DataRequest(93956, 93958, 0, 0).open('GET', '/file/score.lua');
    new DataRequest(93958, 185698, 0, 0).open('GET', '/font/recharge bd.ttf');
    new DataRequest(185698, 211954, 0, 0).open('GET', '/font/RosesareFF0000.ttf');
    new DataRequest(211954, 212130, 0, 0).open('GET', '/font/source.txt');
    new DataRequest(212130, 233486, 0, 0).open('GET', '/font/zekton free.ttf');
    new DataRequest(233486, 862191, 0, 0).open('GET', '/texture/background/menuBackground.png');
    new DataRequest(862191, 862320, 0, 0).open('GET', '/texture/effect/blackscreen.png');
    new DataRequest(862320, 875171, 0, 0).open('GET', '/texture/effect/borderhp.png');
    new DataRequest(875171, 1914159, 0, 0).open('GET', '/texture/effect/expType1.png');
    new DataRequest(1914159, 2310284, 0, 0).open('GET', '/texture/effect/expType2.png');
    new DataRequest(2310284, 2320941, 0, 0).open('GET', '/texture/effect/muzzleflash.png');
    new DataRequest(2320941, 2326435, 0, 0).open('GET', '/texture/effect/muzzleflash11.jpg');
    new DataRequest(2326435, 2331904, 0, 0).open('GET', '/texture/effect/muzzleflashCyan.png');
    new DataRequest(2331904, 2338806, 0, 0).open('GET', '/texture/effect/muzzleflashRed.png');
    new DataRequest(2338806, 2338933, 0, 0).open('GET', '/texture/effect/whitescreen.png');
    new DataRequest(2338933, 2343738, 0, 0).open('GET', '/texture/logo/lua.gif');
    new DataRequest(2343738, 2461552, 0, 0).open('GET', '/texture/logo/lua.png');
    new DataRequest(2461552, 2510182, 0, 0).open('GET', '/texture/logo/moai.png');
    new DataRequest(2510182, 2569326, 0, 0).open('GET', '/texture/logo/moaiattribution_vert_white.png');
    new DataRequest(2569326, 2838162, 0, 0).open('GET', '/texture/logo/title.png');
    new DataRequest(2838162, 2971797, 0, 0).open('GET', '/texture/others/howToPlay.png');
    new DataRequest(2971797, 3032017, 0, 0).open('GET', '/texture/others/key a.png');
    new DataRequest(3032017, 3089380, 0, 0).open('GET', '/texture/others/key d.png');
    new DataRequest(3089380, 3151785, 0, 0).open('GET', '/texture/others/key s.png');
    new DataRequest(3151785, 3215206, 0, 0).open('GET', '/texture/others/key w.png');
    new DataRequest(3215206, 3264157, 0, 0).open('GET', '/texture/others/key.jpg');
    new DataRequest(3264157, 3291516, 0, 0).open('GET', '/texture/scenario/bigStars.png');
    new DataRequest(3291516, 3830007, 0, 0).open('GET', '/texture/scenario/littleStars.png');
    new DataRequest(3830007, 4032756, 0, 0).open('GET', '/texture/scenario/Star.jpg');
    new DataRequest(4032756, 4054466, 0, 0).open('GET', '/texture/scenario/star.png');
    new DataRequest(4054466, 4588813, 0, 0).open('GET', '/texture/scenario/Stars-Space.jpg');
    new DataRequest(4588813, 4607537, 0, 0).open('GET', '/texture/ship/ship10.png');
    new DataRequest(4607537, 4628564, 0, 0).open('GET', '/texture/ship/ship10dmg.png');
    new DataRequest(4628564, 4642574, 0, 0).open('GET', '/texture/ship/ship5.png');
    new DataRequest(4642574, 4656024, 0, 0).open('GET', '/texture/ship/ship5dmg.png');
    new DataRequest(4656024, 4674236, 0, 0).open('GET', '/texture/ship/ship6.png');
    new DataRequest(4674236, 4691672, 0, 0).open('GET', '/texture/ship/ship6dmg.png');
    new DataRequest(4691672, 4706356, 0, 0).open('GET', '/texture/ship/ship7.png');
    new DataRequest(4706356, 4720529, 0, 0).open('GET', '/texture/ship/ship7dmg.png');
    new DataRequest(4720529, 4737715, 0, 0).open('GET', '/texture/ship/ship8.png');
    new DataRequest(4737715, 4755493, 0, 0).open('GET', '/texture/ship/ship8dmg.png');
    new DataRequest(4755493, 4773738, 0, 0).open('GET', '/texture/ship/ship9.png');
    new DataRequest(4773738, 4791217, 0, 0).open('GET', '/texture/ship/ship9dmg.png');
    new DataRequest(4791217, 4796642, 0, 0).open('GET', '/texture/shot/laserblue.png');
    new DataRequest(4796642, 4802025, 0, 0).open('GET', '/texture/shot/lasercyan.png');
    new DataRequest(4802025, 4807464, 0, 0).open('GET', '/texture/shot/lasergreen.png');
    new DataRequest(4807464, 4812705, 0, 0).open('GET', '/texture/shot/lasermagenta.png');
    new DataRequest(4812705, 4818031, 0, 0).open('GET', '/texture/shot/laserred.png');
    new DataRequest(4818031, 4833715, 0, 0).open('GET', '/texture/shot/starshot.png');
    new DataRequest(4833715, 4836642, 0, 0).open('GET', '/texture/shot/low/lasergreen.png');

    if (!Module.expectedDataFileDownloads) {
      Module.expectedDataFileDownloads = 0;
      Module.finishedDataFileDownloads = 0;
    }
    Module.expectedDataFileDownloads++;

    var PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    var PACKAGE_NAME = 'C:/Users/orlan/Dropbox/MOAI/moaicli-windows.1.5.0-rc3/SwiftSpaceBattle/distribute/html/html-debug/www/moaiapp.rom';
    var REMOTE_PACKAGE_NAME = 'moaiapp.rom';
    var PACKAGE_UUID = '694a54f6-44b8-4ce1-8b68-53a70fb51bc0';
  
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
          DataRequest.prototype.requests["/texture/effect/expType1.png"].onload();
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
          DataRequest.prototype.requests["/texture/others/howToPlay.png"].onload();
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
