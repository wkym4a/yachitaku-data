import { Controller } from "stimulus"

import { decided_flg,map_default_setting , map_btn_setting , map_make_one_pin_no_content ,map_delete_pins , map_set_address ,map_set_latlon } from "../commons/map"

// 📍保存用の枠
var pin_box = [];

// 座標が確定されているかどうが」のフラグ
var latlng_decided_flg
// var latlng_decided_flg = [false];

export default class extends Controller {
  static targets = ["decided_flg","map","lat","lon","btn_set","btn_reset","address","btn_save","msg" ]

    connect(e) {

      // 初期表示時に「map_btn_setting（ここでflgを反転させる）」を通すので、ここではTFを反転させた値を取得。
      latlng_decided_flg = [this.decided_flgTarget.value!=='true'];

      this.map = new Y.Map(this.mapTarget.id,{configure : {
                  scrollWheelZoom : true
                }});

      // 地図の初期設定を行う
      map_default_setting(this.map,this.latTarget,this.lonTarget);

      //表示しているピンを消す(念の為、リロード時用？)
      map_delete_pins(this.map,pin_box)

      // ピンを建てる
      map_make_one_pin_no_content(this.map,this.latTarget,this.lonTarget,pin_box)

      // ボタン設定を行う
      map_btn_setting(latlng_decided_flg,this.msgTarget,this.latTarget,this.lonTarget,this.btn_setTargets,this.btn_resetTarget,this.btn_saveTarget);

      /////////////////////////////////////
      var lat_dbc = this.latTarget
      var lon_dbc = this.lonTarget
      var address_dbc = this.addressTarget
      var map_dbc = this.map

          //地図がダブルクリックされた時の処理
          this.map.bind('dblclick', function(e) {

            // すでに座標が確定されている場合は、処理せず抜ける
            if(latlng_decided_flg[0]==true){
              return;
              }

            lat_dbc.value = e.Lat;
            lon_dbc.value = e.Lon;
            address_dbc.value = ""//「住所」を初期化……「座標→住所」で設定し直すため

            //表示しているピンを消す(念の為、リロード時用？)
            map_delete_pins(map_dbc,pin_box)

            // ピンを建てる
            map_make_one_pin_no_content(map_dbc,lat_dbc,lon_dbc,pin_box)

            // var current_location = new Y.LatLng(e.Lat,e.Lon)
            //
            // var marker = new Y.Marker(current_location);
            //
            // map_box.addFeature(marker);
            //
            // if(markers.length > 0){
            //   for (var i = 0; i < markers.length; i++) {
            //     map_box.removeFeature(markers[i]);
            //     // markers[i].setMap(null);
            //   }
            //     markers = [];	//参照を開放
            // }
            // // // 作成したマーカーを保存
            // markers.push(marker);
            //
            // // ピンの場所に移動
            // map_box.panTo(current_location, true);

          });

    }

    // 「座標確定解除」処理
  reset_latlon(){
    // まだ座標が確定されていない場合は、処理せず抜ける
    if(latlng_decided_flg[0]==false){
      return;
    }
    // ボタン設定を行う
    map_btn_setting(latlng_decided_flg,this.msgTarget,this.latTarget,this.lonTarget,this.btn_setTargets,this.btn_resetTarget,this.btn_saveTarget);

  }

  // 【座標→住所】による「座標確定」処理
  set_address_by_latlon(){
    // すでに座標が確定されている場合は、処理せず抜ける
    if(latlng_decided_flg[0]==true){
      return;
      }

    // ----↓↓緯度,経度に関するバリデーション処理↓↓----
    if((this.latTarget.value == "") || (this.lonTarget.value == "") ){
      this.msgTarget.text='緯度、経度を入力してください。'
      return;
    }

    if(isNaN(this.latTarget.value)==true || isNaN(this.lonTarget.value)==true ){
      this.msgTarget.text="緯度、経度には数値を入力してください。"
      return;
    }

    if((this.latTarget.value < -90) || (this.latTarget.value > 90) ||
     (this.lonTarget.value < -180) || (this.lonTarget.value > 180) ){
      this.msgTarget.text='存在しない座標です。\n緯度は「-90」〜「90」、経度は「-180」〜「180」の範囲で入力してください。'
      return;
    }
      // ----↑↑緯度,経度に関するバリデーション処理↑↑----

    //表示しているピンを消す(念の為、リロード時用？)
    map_delete_pins(this.map,pin_box)

    // ピンを建てる+ピンの場所に移動
    map_make_one_pin_no_content(this.map,this.latTarget,this.lonTarget,pin_box)

    // 住所を表示する
    map_set_address(this.msgTarget,this.latTarget,this.lonTarget,this.addressTarget)

    // ボタン設定を行う
    map_btn_setting(latlng_decided_flg,this.msgTarget,this.latTarget,this.lonTarget,this.btn_setTargets,this.btn_resetTarget,this.btn_saveTarget);
  }

    // 【住所→座標】による「座標確定」処理
    set_latlon_by_address(){
      // すでに座標が確定されている場合は、処理せず抜ける
      if(latlng_decided_flg[0]==true){
        return;
        }

      // ----↓↓緯度,経度に関するバリデーション処理↓↓----
      // 住所が存在しない場合は、エラーメッセージを表示して抜ける
      if(this.addressTarget.value == ""){
        this.msgTarget.text="住所を入力してください。";
        return;
      }
      // ----↑↑緯度,経度に関するバリデーション処理↑↑----


      // 住所からの座標設定を行う
      map_set_latlon(latlng_decided_flg,this.map,this.msgTarget,this.latTarget,this.lonTarget,this.addressTarget,this.btn_setTargets,this.btn_resetTarget,this.btn_saveTarget,pin_box);

    }

}
