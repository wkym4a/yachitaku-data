
// 地図の初期設定
export function map_default_setting(map,lat,lon){

  map.drawMap(new Y.LatLng(lat.value, lon.value), 17, Y.LayerSetId.NORMAL);

  var center = new Y.CenterMarkControl
  var control = new Y.LayerSetControl();
  var sliderzoom = new Y.SliderZoomControlVertical();
  var scale = new Y.ScaleControl();
  var searchcontrol = new Y.SearchControl();
  map.addControl(center);
  map.addControl(control);
  map.addControl(sliderzoom);
  map.addControl(scale);
  map.addControl(searchcontrol);

}

// 地図から📍を消す
export function map_delete_pins(map,pin_box){
  if(pin_box.length > 0){
    for (var i = 0; i < pin_box.length; i++) {
      map.removeFeature(pin_box[i]);
    }
      pin_box = [];
  }
}

// 地図に📍を一つ作る
export function map_make_one_pin_no_content(map,lat,lon,pin_box){

  var current_location = new Y.LatLng(lat.value,lon.value);

  var marker = new Y.Marker(current_location);
  // var marker = new Y.Marker(current_location,{title: .pins[i].pin_name});
  map.addFeature(marker);

  // // 作成したマーカーを保存
  pin_box.push(marker);

  // ピンの場所に移動
  map.panTo(current_location, true);

}

// 地図に「ユーザー（管理業者）についての📍(駐車場一覧表示画面用）を作る
export function map_make_user_pin(map,pin_info,pin_box){

  var current_location = new Y.LatLng(pin_info.lat.value,pin_info.lon.value);

  var icon = new Y.Icon("https://chart.googleapis.com/chart?chst=d_map_pin_letter_withshadow&chld=管|00BFFF|000000", {iconSize: new Y.Size(80,80)});

  var marker = new Y.Marker(current_location,{icon: icon,title: pin_info.name.value});

  // urlが設定されていた場合、そのページを別窓で開くようにする。
  var url = ""
  if(!pin_info.url.value==false){
    url = 'href = "' + pin_info.url.value + '" target = "_blank"'
  }

  marker.bindInfoWindow('<div class="speech_bubble_box"><div class="speech_bubble_title"><a ' + url +  '  style="text-decoration: underline">' + pin_info.name.value + '</a></div><div class="speech_bubble_content">住所：' + pin_info.address.value + '</div><div class="speech_bubble_content">電話：' + pin_info.tel.value + '</div><div class="speech_bubble_content">FAX：' + pin_info.fax.value + '</div><div class="speech_bubble_content">' + pin_info.memo.value + '</div></div>');

  map.addFeature(marker);

  // // 作成したマーカーを保存
  pin_box.push(marker);

  // ピンの場所に移動
  map.panTo(current_location, true);

}

// 地図に「駐車場についての📍(駐車場一覧表示画面用）」を作る
export function map_make_parking_pin(map,pin_info,pin_box){
// export function map_make_parking_pin(map,lat,lon,pin_box,icon_info,title_info,address_info,price_info,memo_info){

  var current_location = new Y.LatLng(pin_info.lat.value,pin_info.lon.value);

  if (pin_info.status.value == "空き無し") {
    var icon = new Y.Icon("https://chart.googleapis.com/chart?chst=d_map_pin_letter_withshadow&chld=" + pin_info.symbol.value +  "|808080|000000", {iconSize: new Y.Size(80,80)});
  } else {
    var icon = new Y.Icon("https://chart.googleapis.com/chart?chst=d_map_pin_letter_withshadow&chld=" + pin_info.symbol.value +  "|FF6666|000000", {iconSize: new Y.Size(80,80)});
  }


  var marker = new Y.Marker(current_location,{icon: icon,title: pin_info.name.value});

  marker.bindInfoWindow('<div data-controller="make-speech-bubble" class="speech_bubble_box"><div class="speech_bubble_title">' + pin_info.name.value +'</div><div class="speech_bubble_content">' + pin_info.status.value +'(' + pin_info.number.value +'台中、' + pin_info.empty_number.value +'台空き)</div><div class="speech_bubble_content">所在地：' + pin_info.address.value +'</div><div class="speech_bubble_content">賃料：' + pin_info.price.value +'円/月</div><div class="speech_bubble_content" style = "white-space:pre-wrap">' + pin_info.memo.value +'</div></div>');

  map.addFeature(marker);

  // // 作成したマーカーを保存
  pin_box.push(marker);
}

export function map_btn_setting(flg,msg,lat,lon,btn_set,btn_reset,btn_save){
  msg.text=""//メッセージ枠は空欄に戻す

  if(flg[0]==false){
  // 座標を設定した
  // →変更前のフラグが「座標がまだ設定されていない」だった場合
    flg[0] = true
    lat.readOnly = true;
    lon.readOnly = true;
    btn_set[0].style.backgroundColor = '#555555';
    btn_set[1].style.backgroundColor = '#555555';
    btn_reset.style.backgroundColor = '#A7F1FF';
    btn_save.disabled = false;

  } else {
  // 座標設定を解除した
  // →変更前のフラグが「座標がもう設定されている」だった場合

    flg[0] = false
    lat.readOnly = false;
    lon.readOnly = false;
    btn_set[0].style.backgroundColor = '#A7F1FF';
    btn_set[1].style.backgroundColor = '#A7F1FF';
    btn_reset.style.backgroundColor = '#555555';
    btn_save.disabled = true;

  }
}

// 地
export function map_set_address(msg,lat,lon,address){

  var current_location = new Y.LatLng(lat.value,lon.value)
  var request = { "latlng": current_location };

  var geocoder = new Y.GeoCoder();

  geocoder.execute( request , function(ydf) {
      if ( ydf.features.length > 0 ) {
          var feature = ydf.features[0];

          if(feature.property.Address==""){
            address.value=feature.property.Country.Name;
          }else{
            address.value=feature.property.Address;
          }

      }else{
          msg.text="座標から住所を獲得できませんでした。住所は手入力で入力してください。";
      }

  } );
}


export function map_set_latlon(flg,map,msg,lat,lon,address,btn_sets,btn_reset,btn_save,pin_box){

  var map_in_g = map
  var request = { query : address.value };
  var geocoder = new Y.GeoCoder();

  geocoder.execute( request , function( ydf ) {
    if ( ydf.features.length > 0 ) {

      lat.value =ydf.features[0]["latlng"]["Lat"];
      lon.value =ydf.features[0]["latlng"]["Lon"];

      ////// ↓マーカー作成→既存マーカー削除→作成したメーカーを設置→作成マーカーを保存
      var current_location = new Y.LatLng(lat.value,lon.value)

      var marker = new Y.Marker(current_location);

      //表示しているピンを消す
      map_delete_pins(map,pin_box)

      // 新たなピンを表示
      map.addFeature(marker);

      // // 作成したピンを保存
      pin_box.push(marker);

      // ピンの場所に移動
      map.panTo(current_location, true);
      ////// ↑マーカー作成→既存マーカー削除→作成したメーカーを設置→作成マーカーを保存

      // ボタン設定を行う
      map_btn_setting(flg,msg,lat,lon,btn_sets,btn_reset,btn_save);

    }else{
      //【住所から座標を獲得できなかった場合の処理】
      msg.text="住所から座標を獲得できませんでした。"
      return;
    }
  } );
}
