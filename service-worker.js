const PRECACHE = 'BANanoVMDemo-Data-v1584789498860';const RUNTIME = 'BANanoVMDemo-runtime-v1584789498860';const PRECACHE_URLS = ['./index.html','./manifest.json','./scripts/app1584789498860.js','./styles/app1584789498860.css','./assets/1.png','./assets/fonts.zip','./assets/2.png','./assets/gray.png','./assets/green.png','./assets/happyface.png','./assets/icons.svg','./assets/neutralface.png','./assets/orange.png','./assets/red.png','./assets/sadface.png','./assets/upload.php','./assets/1.jpg','./assets/autocomplete.png','./assets/richtext.png','./assets/scheduler.png','./assets/scrollview.png','./assets/search.png','./assets/segmented.png','./assets/select.png','./assets/sidebar.png','./assets/sidemenu.png','./assets/sky.jpg','./assets/slider.png','./assets/avatar.png','./assets/snackbar.png','./assets/spacer.png','./assets/speeddial.png','./assets/sponge.png','./assets/spreadsheet.png','./assets/squirrel.jpg','./assets/stepper.png','./assets/submenu.png','./assets/suggest.png','./assets/switch.png','./assets/badge.png','./assets/tabbar.png','./assets/table.png','./assets/tabs.png','./assets/tabview.png','./assets/telephone.png','./assets/template.png','./assets/text.png','./assets/textarea.png','./assets/time.png','./assets/toggle.png','./assets/barcode.png','./assets/toolbar.png','./assets/tooltip.png','./assets/tree.png','./assets/treegrid.png','./assets/treemap.png','./assets/treetable.png','./assets/unitlist.png','./assets/uploader.png','./assets/vbanner.jpg','./assets/bg-2.jpg','./assets/video.png','./assets/window.png','./assets/bird.jpg','./assets/bottombar.png','./assets/bulletgraph.png','./assets/button.png','./assets/calendar.png','./assets/2.jpg','./assets/card.png','./assets/carousel.png','./assets/chart.png','./assets/checkbox.png','./assets/chip.png','./assets/chips.png','./assets/colorboard.png','./assets/colorpicker.png','./assets/combo.png','./assets/Combo-icon.png','./assets/3.jpg','./assets/comments.png','./assets/config.php','./assets/confirm.png','./assets/context.png','./assets/context-icon.png','./assets/contextmenu.png','./assets/counter.png','./assets/dark-beach.jpg','./assets/database.png','./assets/datasuggest.png','./assets/4.jpg','./assets/datatable.png','./assets/datatree.png','./assets/dataview.png','./assets/datepicker.png','./assets/daterange.png','./assets/daterangepicker.png','./assets/dbase.txt','./assets/dialog.png','./assets/divider.png','./assets/doublelist.png','./assets/5.jpg','./assets/email.png','./assets/excelviewer.png','./assets/fieldset.png','./assets/filemanager.png','./assets/form.png','./assets/formcontrol.png','./assets/forminput.png','./assets/gage.png','./assets/geochart.png','./assets/googlemap.png','./assets/accordion.png','./assets/gridsuggest.png','./assets/grouplist.png','./assets/headerlayout.png','./assets/hint.png','./assets/host.txt','./assets/htmlform.png','./assets/icon.png','./assets/iconbutton.png','./assets/iframe.png','./assets/image.png','./assets/accordionitem.png','./assets/infobox.png','./assets/kanban.png','./assets/label.png','./assets/layout.png','./assets/list.png','./assets/material.jpg','./assets/menu.png','./assets/multicombo.png','./assets/multiselect.png','./assets/multitext.png','./assets/multiview.png','./assets/navbar.png','./assets/numberinput.png','./assets/organogram.png','./assets/pager.png','./assets/password.png','./assets/pdfviewer.png','./assets/pivot.png','./assets/planet.jpg','./assets/popup.png','./assets/alert.png','./assets/portlet.png','./assets/profilepic.png','./assets/prompt.png','./assets/propertysheet.png','./assets/querybuilder.png','./assets/radio.png','./assets/rangechart.png','./assets/rangeslider.png','./assets/resizer.png','./assets/richselect.png'];var _B=this;_B.addEventListener('install', function (event) {event.waitUntil(caches.open(PRECACHE).then(function (cache) {return cache.addAll(PRECACHE_URLS);}).then(_B.skipWaiting()));});_B.addEventListener('activate', function (event) {var currentCaches = [PRECACHE, RUNTIME];event.waitUntil(caches.keys().then(function (cacheNames) {return cacheNames.filter(function (cacheName) {return !currentCaches.includes(cacheName);});}).then(function (cachesToDelete) {return Promise.all(cachesToDelete.map(function (cacheToDelete) {return caches.delete(cacheToDelete);}));}).then(function () {return _B.clients.claim();}));});_B.addEventListener('fetch', function (event) {if (event.request.url.indexOf('donotdelete.gif') == -1) {event.respondWith(caches.match(event.request).then(function (cachedResponse) {if (cachedResponse) {return cachedResponse;}return caches.open(RUNTIME).then(function (cache) {return fetch(event.request).then(function (response) {return cache.put(event.request, response.clone()).then(function () {return response;});});});}));}});