$(function(){
  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $('form').on('change', 'input[type="file"]', function(e) {
    // 『e.target』でイベントが発生したDOM要素を取得。
    // イベントは要素を伝わって移動する為。兄弟や子孫ではなく、親へ伝わる。
    // 『.files』で選択ファイルを配列形式で取得。（『FileList』となっている。）
    // [0]を付加する事で、その中の『File』について取り出すことが可能。
    var file = e.target.files[0],
        // オブジェクトを生成
        reader = new FileReader();
        // １：$preview = $("#main_preview");
        t = this;

    //ページ内、すべてに対応させる為に記述。
    // ①hamlを書き換え、ファイルを選択する要素の次兄弟に画像を差し込む要素を設定。
    // ②次兄弟な為、『next~』で差し込む箇所の要素を取得し、取得物からjQueryオブジェクト を生成。
    // ③生成した箇所に対して処理を行う。（47行目あたり）
    // ※場所が固定されている場合処理が『１：』
    var sibling = e.target.nextElementSibling;
    var sibling_object = new jQuery.fn.init(sibling, undefined, $(document));
    // console.log(sibling);
    // console.log(sibling_object);

    //id名から要素（DOM）を取得の方法（『sibling』が同等の為、不要）
    // var sibling_id = sibling.id;
    // var dom_element = document.getElementById(sibling_id);
    // var sibling_object = new jQuery.fn.init(dom_element, undefined, $(document));

    //使用しているものの確認用
    // console.log(e.target);
    // console.log(file);
    // console.log(file.type);
    // console.log(file.type.indexOf("image"));

    //１：『$("クラス・id名")』で何が生成されるのか、確認用
    // console.log($preview);
    // var example = new jQuery.fn.init($preview, undefined, $(document));
    // console.log(example);

    // 画像ファイルかの判定
    //  『indexOf(引数)』引数で与えた文字列より前に何文字あるか値を返す。
    //   最初の場合、0が返り、存在しない場合は−１が返る。
    if(file.type.indexOf("image") < 0){
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        // 既存のプレビューを削除
        sibling_object.empty();
        // １：$preview.empty();
        // 領域の中に画像を表示するimageタグを追加
        sibling_object.append($('<img>').attr({
        // １：$preview.append($('<img>').attr({
                  // ロードされた画像ファイルのData URIスキームの格納場所
                  src: e.target.result,
                  id: "main_preview",
                  title: file.name
              }));
      };
    })(file);

    reader.readAsDataURL(file);
  });
});
