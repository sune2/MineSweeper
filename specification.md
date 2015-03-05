# マインスイーパ設計書 #

## 画面 ##

### タイトル ###

* タイトル
* Start
    * Easy
    * Normal
    * Hard

### ゲーム画面 ###

#### 通常時 ####

* Menu
* ゲーム画面

#### ゲームオーバー時 ####

（ポップアップ表示）
* もう一度
* タイトルへ戻る

## クラス ##

* TitleScene : SKScene // タイトル
    * TitleLogoNode : SKNode // タイトルロゴ
    * TitleMenuNode : SKNode // タイトルメニュー
* GameScene : GameScene // ゲーム
    * GameMainNode : SKNode // マインスイーパ本体
        * GameCellNode : SKNode // セル
        * GameModeNode : SKNode // モード（通常，旗）選択用
    * GameMenuNode : SKNode // ゲームメニュー
    * GameOverNode : SKNode // ゲームオーバー
