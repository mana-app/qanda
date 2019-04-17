// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery

$(function() {
    // レスポンシブデザイン
    // click()では、後からHTMLを変更した場合に動作しないため、on()を使用する
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.menu-icon').length) {
            // ターゲット以外の要素をクリックしたときの処理
            if ($('.nav-overlap').hasClass('nav-open')) {
                navClose();
            }
        } else {
            // ターゲットをクリックしたときの処理
            if ($('.nav-overlap').hasClass('nav-open')) {
                navClose();
            } else {
                navOpen();
            }
        }
    });
  
    function navClose() {
        $('.nav-overlap').removeClass('nav-open');
        $('.menu-icon').removeClass('open');
        $('.nav-overlap').slideUp('fast');
        $('.nav-overlap-background').fadeOut('fast');
    }
  
    function navOpen() {
        $('.nav-overlap').addClass('nav-open');
        $('.menu-icon').addClass('open');
        $('.nav-overlap').slideDown('fast');
        $('.nav-overlap-background').fadeIn('fast');
    }

    // フラッシュメッセージの自動消去
    setTimeout(function() {
        $('.flash').fadeOut('slow');
    }, 3000);
});

/* rails5ではturbolinksにより、トップページ以外は、$(document).ready()が動かない。 */
// 初回読み込み、リロード、ページ切り替えで動く。
$(document).on('turbolinks:load', function() {
    // helpページのアコーディオン
    $(function() {
        $('.help-question').click(function() {
            var $answer =  $(this).next('.help-answer');
            if ($answer.hasClass('accordion-open')) {
                $answer.removeClass('accordion-open');
                $answer.slideUp('fast');
                $(this).find('span').text('+');
            } else {
                $answer.addClass('accordion-open');
                $answer.slideDown('fast');
                $(this).find('span').text('-');
            }
        });
    });

    // テキストエリアの文字数表示
    if ( $('textarea').length ) {
        // ページ表示時
        var charLength = $('textarea').val().length;
        $('#characters-count').text(charLength)

        // 文字入力時
        $('textarea').keyup(function() {
            var charLength = $(this).val().length;
            $('#characters-count').text(charLength);
        });
    }
});
