# VRChat におけるゲーム内設定とレジストリ値

VRChat の設定はほぼすべてがレジストリに登録されている。この記事ではゲーム内での設定項目と、その設定がどのレジストリ項目に反映されるかを調査してまとめたもの。  
なお、一部の設定値は `reg query` コマンドでは正しい値が出力されないため注意（`reg export` を用いて調査した）

## レジストリ項目

### _LastExpiredSubscription_h2460695364

- 種類: `REG_BINARY`

不明

VRChat Plus の契約が切れた日付とかが記録される？現在 VRChat Plus を契約中のため、この値は `hex:00` だった。

### 14C4B06B824EC593239362517F538B29_h1518735675

- 種類: `REG_BINARY`

### 5F4DCC3B5AA765D61D8327DEB882CF99_h997075211

- 種類: `REG_BINARY`

### 785C2BDD2C43070A10BC35E5E687A467_h2366186322

- 種類: `REG_BINARY`

### 93D3AE97F80BEDA8E396065DC4770A93_h1522417508

- 種類: `REG_BINARY`

### AUDIO_GAME_AVATARS_ENABLED_h1043985701

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `Avatars` にある、一番右のスピーカーアイコンのオンオフ状態。  
Mute で `dword:00000000`、Unmute で `dword:00000001`

### AUDIO_GAME_AVATARS_h1193528447

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `Avatars` の設定値。データの詳細は [共通のデータ > パーセンテージ](#common-percentage) を参照。

### AUDIO_GAME_SFX_ENABLED_h3370237354

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `World` にある、一番右のスピーカーアイコンのオンオフ状態。  
Mute で `dword:00000000`、Unmute で `dword:00000001`

### AUDIO_GAME_SFX_h4252337136

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `World` の設定値。データの詳細は [共通のデータ > パーセンテージ](#common-percentage) を参照。

### AUDIO_GAME_VOICE_ENABLED_h2864962737

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `Voices` にある、一番右のスピーカーアイコンのオンオフ状態。  
Mute で `dword:00000000`、Unmute で `dword:00000001`

### AUDIO_GAME_VOICE_h821266155

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `Voices` の設定値。データの詳細は [共通のデータ > パーセンテージ](#common-percentage) を参照。

### AUDIO_MASTER_ENABLED_h3453344810

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `Master` にある、一番右のスピーカーアイコンのオンオフ状態。  
Mute で `dword:00000000`、Unmute で `dword:00000001`

### AUDIO_MASTER_h1232282224

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `Master` の設定値。データの詳細は [共通のデータ > パーセンテージ](#common-percentage) を参照。

### AUDIO_UI_ENABLED_h2428663594

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `UI/Menu` にある、一番右のスピーカーアイコンのオンオフ状態。  
Mute で `dword:00000000`、Unmute で `dword:00000001`

### AUDIO_UI_h3270819184

- 種類: `REG_DWORD`

`Audit & Voice` の `Audio Volume` セクション内 `UI/Menu` の設定値。データの詳細は [共通のデータ > パーセンテージ](#common-percentage) を参照。

### AVATAR_WORN_HISTORY_usr_0b83d9be-9852-42dd-98e2-625062400acc_h3163993027

- 種類: `REG_BINARY`

以下のような JSON データがバイナリで保存されている。  
`Avatars` タブの `Recently used` を表示するための、アバター最終使用日時と思われる。

```json
{
  "local:sdk_Milk-Re_v3 (Furisode)": "2024-12-23T19:05:34.7400725Z",
  "avtr_acfe6cbe-b5d7-4245-9c57-c7de80b9e2e8": "2024-12-21T10:53:00.8779875Z",
  "avtr_f3f66033-0693-4061-9b14-1ddd7d8b9035": "2024-12-31T18:00:50.6977167Z",
  "avtr_d6e9f92c-50c2-4d4b-8d67-61f847b0b7bb": "2025-01-03T12:59:59.6349111Z",
  "avtr_e75d4134-0913-4e40-9446-20fdead73dbe": "2025-01-01T06:43:48.294398Z",
  "avtr_e3784f2c-f91b-4849-8c02-3085a286d8de": "2024-12-20T12:16:02.32497Z",
  "avtr_84be7935-28d7-48e6-8543-014ab5f3956a": "2025-01-02T20:18:53.579114Z",
  "avtr_571ea10a-bf73-4bf1-bda7-1b328fb37ba0": "2024-12-31T05:41:56.2762585Z",
  "avtr_9f225f26-f829-4c05-8e0e-9e0cd8271700": "2025-01-02T20:18:45.6004369Z",
  "avtr_6f82fcb7-71e3-4614-b830-3d528d8c4215": "2025-01-03T12:47:40.7824105Z",
  "avtr_b481e57f-6cf8-4339-8150-a076eaf6c5bc": "2024-12-29T07:56:14.0799083Z",
  "avtr_d9f9d802-e7c6-4d4d-9d78-9bb31e6d1bc6": "2025-01-03T12:58:04.2353828Z",
  "avtr_f3b0389d-3957-4750-aae1-528eab998499": "2024-12-31T18:01:34.9876062Z",
  "avtr_0a0c6b10-529a-4854-91ea-9d4dd42d375d": "2024-12-31T17:59:22.4380911Z",
  "avtr_6a2d677b-fe04-4e79-912a-9ee5ca69d189": "2025-01-03T13:35:39.0940496Z",
  "avtr_cc1a49d6-60cd-4412-856d-f625fef9bc72": "2024-12-25T14:44:50.9870779Z",
  "avtr_98605076-9496-405c-9bd5-d56bc6486c68": "2024-12-29T07:56:37.5304084Z",
  "avtr_bbd51417-d181-4f96-bf64-50363b7b9d29": "2024-12-31T17:58:45.3456933Z",
  "avtr_3f1c3a5e-ff1f-4408-8260-6c9190cc5e61": "2024-12-20T17:05:46.6981665Z",
  "avtr_f8c7ec93-dbf7-4409-96b8-b47b5dd7cc03": "2024-12-31T16:45:48.3238212Z",
  "avtr_f9a05862-53fb-4f6b-988a-334157b679f8": "2025-01-03T15:07:39.7051366Z",
  "avtr_0491eb35-b73e-4bd4-b55c-6cb9c7d3ba10": "2025-01-03T12:39:17.9739706Z",
  "avtr_7f400cd7-648a-4f43-b97e-6fec319e465a": "2025-01-03T12:55:11.6557627Z",
  "avtr_2f2b067b-dde7-47f1-a937-dddd44b6e013": "2024-12-31T17:32:31.9710892Z",
  "avtr_7936dbf2-0a64-40fc-843a-f10acc03a3ba": "2025-01-03T12:57:18.7010019Z"
}
```

### avatarProxyAlwaysShowExplicit_h3831300188

- 種類: `REG_DWORD`

### avatarProxyAlwaysShowFriends_h4183870315

- 種類: `REG_DWORD`

### avatarProxyShowAtRange_h3229000273

- 種類: `REG_DWORD`

### avatarProxyShowAtRangeToggle_h3274849731

- 種類: `REG_DWORD`

### avatarProxyShowMaxNumber_h171091884

- 種類: `REG_DWORD`

### BACKGROUND_MATERIAL__h2413817760

- 種類: `REG_BINARY`

### BACKGROUND_MATERIAL_usr_0b83d9be-9852-42dd-98e2-625062400acc_h2018898670

- 種類: `REG_BINARY`

### BACKGROUND_MATERIAL_usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_h3641400327

- 種類: `REG_BINARY`

### BCD9D91ED8D8F1926B20D3D620647C8E_h2167456022

- 種類: `REG_BINARY`

### BD2E932A03A19217AB5A1DFB5AA93340_h1920873149

- 種類: `REG_BINARY`

### BestRegionCache_h195528817

- 種類: `REG_DWORD`

### COLOR_PALETTES_CURRENT_usr_0b83d9be-9852-42dd-98e2-625062400acc_h947530926

- 種類: `REG_BINARY`

### COLOR_PALETTES_CURRENT_usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_h831006407

- 種類: `REG_BINARY`

### COLOR_PALETTES_usr_0b83d9be-9852-42dd-98e2-625062400acc_h4097439800

- 種類: `REG_BINARY`

### COLOR_PALETTES_usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_h1389871057

- 種類: `REG_BINARY`

### currentShowMaxNumberOfAvatarsEnabled_h1218052438

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanSpeak_h3763947065

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseAnimatedEmoji_h2886526733

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseAvatarAudio_h4256062353

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseCustomAnimations_h3337768320

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseCustomAvatar_h4019586932

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseCustomShaders_h168543583

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseEmojiStickersSharing_h4033281752

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseParticleSystems_h1743590900

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseTriggers_h846144093

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel1_CanUseUserIcons_h2350386015

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanSpeak_h3560718042

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseAnimatedEmoji_h3705134862

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseAvatarAudio_h3781309970

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseCustomAnimations_h1661613411

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseCustomAvatar_h2790985623

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseCustomShaders_h3297944668

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseEmojiStickersSharing_h3212822779

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseParticleSystems_h3624546359

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseTriggers_h440405630

- 種類: `REG_DWORD`

### CustomTrustLevel_AdvancedTrustLevel2_CanUseUserIcons_h3748203228

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanSpeak_h1255185612

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseAnimatedEmoji_h2703477208

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseAvatarAudio_h2055107012

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseCustomAnimations_h551221237

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseCustomAvatar_h616828545

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseCustomShaders_h3849841034

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseEmojiStickersSharing_h178918381

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseParticleSystems_h1309549665

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseTriggers_h3846697192

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel_CanUseUserIcons_h10967690

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanSpeak_h3469223421

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseAnimatedEmoji_h925748169

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseAvatarAudio_h3089780821

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseCustomAnimations_h18504516

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseCustomAvatar_h3157635888

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseCustomShaders_h3218222107

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseEmojiStickersSharing_h1028214684

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseParticleSystems_h2677083824

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseTriggers_h2886381593

- 種類: `REG_DWORD`

### CustomTrustLevel_BasicTrustLevel1_CanUseUserIcons_h2605731867

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanSpeak_h1348479936

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseAnimatedEmoji_h1224270932

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseAvatarAudio_h2668824904

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseCustomAnimations_h160905209

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseCustomAvatar_h3979433357

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseCustomShaders_h2833000710

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseEmojiStickersSharing_h305271009

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseParticleSystems_h1253552877

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseTriggers_h737962724

- 種類: `REG_DWORD`

### CustomTrustLevel_DeveloperTrustLevel_CanUseUserIcons_h1109555974

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanSpeak_h1076804550

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseAnimatedEmoji_h1841941650

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseAvatarAudio_h3272095374

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseCustomAnimations_h2442825087

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseCustomAvatar_h3238784139

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseCustomShaders_h2830625984

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseEmojiStickersSharing_h2183515111

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseParticleSystems_h281854379

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseTriggers_h934581346

- 種類: `REG_DWORD`

### CustomTrustLevel_Friend_CanUseUserIcons_h1860207168

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanSpeak_h1176565206

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseAnimatedEmoji_h1117716610

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseAvatarAudio_h4212765342

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseCustomAnimations_h2413592431

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseCustomAvatar_h4241088155

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseCustomShaders_h2968004816

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseEmojiStickersSharing_h1375262199

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseParticleSystems_h2892802491

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseTriggers_h60494450

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel1_CanUseUserIcons_h1827811920

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanSpeak_h1379794229

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseAnimatedEmoji_h299108481

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseAvatarAudio_h392550429

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseCustomAnimations_h4089747340

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseCustomAvatar_h1174722168

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseCustomShaders_h4133571027

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseEmojiStickersSharing_h2195721172

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseParticleSystems_h1011847032

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseTriggers_h466232913

- 種類: `REG_DWORD`

### CustomTrustLevel_IntermediateTrustLevel2_CanUseUserIcons_h429994707

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanSpeak_h529273413

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseAnimatedEmoji_h2124802033

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseAvatarAudio_h1316703981

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseCustomAnimations_h1588360380

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseCustomAvatar_h472420744

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseCustomShaders_h2743984803

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseEmojiStickersSharing_h428198308

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseParticleSystems_h267795400

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseTriggers_h328568481

- 種類: `REG_DWORD`

### CustomTrustLevel_KnownTrustLevel_CanUseUserIcons_h153105955

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanSpeak_h515219031

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseAnimatedEmoji_h1482987171

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseAvatarAudio_h832871359

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseCustomAnimations_h1184402734

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseCustomAvatar_h2633444506

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseCustomShaders_h1446172145

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseEmojiStickersSharing_h1041849526

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseParticleSystems_h1335743258

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseTriggers_h2350696243

- 種類: `REG_DWORD`

### CustomTrustLevel_LegendTrustLevel_CanUseUserIcons_h1201635313

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanSpeak_h243867914

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseAnimatedEmoji_h3420779230

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseAvatarAudio_h1841594050

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseCustomAnimations_h2161804467

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseCustomAvatar_h4127243719

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseCustomShaders_h1889644300

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseEmojiStickersSharing_h1810816555

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseParticleSystems_h2356358631

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseTriggers_h4035079598

- 種類: `REG_DWORD`

### CustomTrustLevel_LocalPlayer_CanUseUserIcons_h2261467020

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanSpeak_h772597077

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseAnimatedEmoji_h2585269473

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseAvatarAudio_h1603765245

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseCustomAnimations_h4136943532

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseCustomAvatar_h1380474008

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseCustomShaders_h4066056115

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseEmojiStickersSharing_h813935796

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseParticleSystems_h223698136

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseTriggers_h685335985

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel_CanUseUserIcons_h2084200243

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanSpeak_h2069813380

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseAnimatedEmoji_h3935967248

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseAvatarAudio_h198134284

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseCustomAnimations_h3837572029

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseCustomAvatar_h2356867913

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseCustomShaders_h3068590274

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseEmojiStickersSharing_h1804956069

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseParticleSystems_h3820524969

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseTriggers_h2205354144

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel1_CanUseUserIcons_h4041133506

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanSpeak_h3810459495

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseAnimatedEmoji_h3019473939

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseAvatarAudio_h3934249103

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseCustomAnimations_h1474632030

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseCustomAvatar_h3323951018

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseCustomShaders_h1346165697

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseEmojiStickersSharing_h2931111686

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseParticleSystems_h3777366634

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseTriggers_h4088384771

- 種類: `REG_DWORD`

### CustomTrustLevel_NegativeTrustLevel2_CanUseUserIcons_h4130926145

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanSpeak_h251570915

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseAnimatedEmoji_h2054426647

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseAvatarAudio_h1547181451

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseCustomAnimations_h2568844250

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseCustomAvatar_h1956533038

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseCustomShaders_h3778529477

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseEmojiStickersSharing_h1982058114

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseParticleSystems_h3319727214

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseTriggers_h1979213703

- 種類: `REG_DWORD`

### CustomTrustLevel_TrustedTrustLevel_CanUseUserIcons_h390707781

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanSpeak_h3561541626

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseAnimatedEmoji_h329675886

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseAvatarAudio_h231222002

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseCustomAnimations_h3535915395

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseCustomAvatar_h47678391

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseCustomShaders_h3257793852

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseEmojiStickersSharing_h2030089179

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseParticleSystems_h3087058583

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseTriggers_h2039985630

- 種類: `REG_DWORD`

### CustomTrustLevel_Untrusted_CanUseUserIcons_h532209980

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanSpeak_h1153197229

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseAnimatedEmoji_h155691801

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseAvatarAudio_h3757975173

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseCustomAnimations_h1948517652

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseCustomAvatar_h346242528

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseCustomShaders_h1768628299

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseEmojiStickersSharing_h70476108

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseParticleSystems_h751810528

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseTriggers_h1999113673

- 種類: `REG_DWORD`

### CustomTrustLevel_VeryNegativeTrustLevel_CanUseUserIcons_h1558057803

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanSpeak_h299423817

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseAnimatedEmoji_h2970100605

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseAvatarAudio_h150073185

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseCustomAnimations_h2019714992

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseCustomAvatar_h531332996

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseCustomShaders_h1331804975

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseEmojiStickersSharing_h560691624

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseParticleSystems_h2206752580

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseTriggers_h1591068589

- 種類: `REG_DWORD`

### CustomTrustLevel_VeteranTrustLevel_CanUseUserIcons_h1134160815

- 種類: `REG_DWORD`

### DEFAULT_GROUP_usr_0b83d9be-9852-42dd-98e2-625062400acc_h4094411135

- 種類: `REG_BINARY`

### E1F946CE2FD302B954E26AD92C0B30BF_h577412776

- 種類: `REG_BINARY`

### FaceMirrorOwner_h1560350044

- 種類: `REG_DWORD`

### FIELD_OF_VIEW_h2031753091

- 種類: `REG_DWORD`

### FOLDOUT_STATES_h2348100881

- 種類: `REG_BINARY`

### ForceSettings_ClearFoldoutPrefKeys_h4157079793

- 種類: `REG_DWORD`

### ForceSettings_MicToggle_h3560290679

- 種類: `REG_DWORD`

### ForceSettings_MigrateMicSettings_h381240097

- 種類: `REG_DWORD`

### ForceSettings_Mixer_h3729000201

- 種類: `REG_DWORD`

### ForceSettings_WorldTooltipMode_h79299318

- 種類: `REG_DWORD`

### FPS_LIMIT_h3202401354

- 種類: `REG_DWORD`

### FPSCapType_h2453803306

- 種類: `REG_DWORD`

### FPSType_h850469784

- 種類: `REG_DWORD`

### FRIEND_LAST_VISIT_HISTORY_usr_0b83d9be-9852-42dd-98e2-625062400acc_h3852470368

- 種類: `REG_BINARY`

### FRIEND_LAST_VISIT_HISTORY_usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_h510437897

- 種類: `REG_BINARY`

### GiftDropNoRefundAfterUsageAgreeToggle_h3034415416

- 種類: `REG_DWORD`

### HasSeenMassGiftQMCalloutusr_0b83d9be-9852-42dd-98e2-625062400acc_h3684067692

- 種類: `REG_DWORD`

### HasSeenPrintsQMCalloutusr_0b83d9be-9852-42dd-98e2-625062400acc_h3918105566

- 種類: `REG_DWORD`

### HasSeenPrintsUserCameraCalloutusr_0b83d9be-9852-42dd-98e2-625062400acc_h1686627754

- 種類: `REG_DWORD`

### InQueueWidgetInfoShowcaseID_h185847275

- 種類: `REG_DWORD`

### LocationContext_h2266281351

- 種類: `REG_DWORD`

よくわからないが、インスタンス移動中は `dword:00000001`、移動完了後は `dword:00000000`？

### LocationContext_World_h2703649242

- 種類: `REG_BINARY`

現在いるワールドのワールド ID とワールド名がバーティカルバー区切りで記録される。

例: `hex:77,72,6c,64,5f,62,65,30,37,36,37,37,37,2d,38,31,39,66,2d,34,61,36,31,2d,61,31,30,65,2d,33,32,65,35,35,39,66,39,36,38,31,33,7c,54,6f,6d,61,48,6f,6d,65,00` → `wrld_be076777-819f-4a61-a10e-32e559f96813|TomaHome`

### LOD_QUALITY_h4091515664

- 種類: `REG_DWORD`

### LOGGING_ENABLED_h120798204

- 種類: `REG_DWORD`

### migrated-local-pmods-usr_0b83d9be-9852-42dd-98e2-625062400acc-HideAvatar_h887372855

- 種類: `REG_DWORD`

### migrated-local-pmods-usr_0b83d9be-9852-42dd-98e2-625062400acc-ShowAvatar_h2376242356

- 種類: `REG_DWORD`

### migrated-local-pmods-usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481-HideAvatar_h81596350

- 種類: `REG_DWORD`

### migrated-local-pmods-usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481-ShowAvatar_h2134712893

- 種類: `REG_DWORD`

### PARTICLE_PHYSICS_QUALITY_h1323555479

- 種類: `REG_DWORD`

### PersonalMirror.FaceMirrorOpacity_h864053611

- 種類: `REG_DWORD`

### PersonalMirror.FaceMirrorPosX_h1476246502

- 種類: `REG_DWORD`

### PersonalMirror.FaceMirrorPosY_h1476246503

- 種類: `REG_DWORD`

### PersonalMirror.FaceMirrorScale_h1462894506

- 種類: `REG_DWORD`

### PersonalMirror.FaceMirrorZoom_h1476308997

- 種類: `REG_DWORD`

### PersonalMirror.Grabbable_h1518415444

- 種類: `REG_DWORD`

### PersonalMirror.ImmersiveMove_h2179321036

- 種類: `REG_DWORD`

### PersonalMirror.MirrorOpacity_h69462026

- 種類: `REG_DWORD`

### PersonalMirror.MirrorScaleX_h1013638771

- 種類: `REG_DWORD`

### PersonalMirror.MirrorScaleY_h1013638770

- 種類: `REG_DWORD`

### PersonalMirror.MirrorSnapping_h3804860783

- 種類: `REG_DWORD`

### PersonalMirror.MovementMode_h997156426

- 種類: `REG_DWORD`

### PersonalMirror.ShowBorder_h1746149253

- 種類: `REG_DWORD`

### PersonalMirror.ShowCalibrationMirror_h2508718650

- 種類: `REG_DWORD`

### PersonalMirror.ShowEnvironmentInMirror_h2340098914

- 種類: `REG_DWORD`

### PersonalMirror.ShowFaceMirror_h3365452145

- 種類: `REG_DWORD`

### PersonalMirror.ShowRemotePlayerInMirror_h3819163776

- 種類: `REG_DWORD`

### PersonalMirror.ShowUIInMirror_h1637241803

- 種類: `REG_DWORD`

### PIXEL_LIGHT_COUNT_h158099248

- 種類: `REG_DWORD`

### PlayerHeight_h2758831273

- 種類: `REG_DWORD`

### PREF_HAND_TRACKING_TUTORIAL_COMPLETED_h1338813193

- 種類: `REG_DWORD`

### Preload_Worlds_HISTORY_usr_0b83d9be-9852-42dd-98e2-625062400acc_h3618586342

- 種類: `REG_BINARY`

### RECENTLY_VISITED_HISTORY_usr_0b83d9be-9852-42dd-98e2-625062400acc_h2027203416

- 種類: `REG_BINARY`

### RECENTLY_VISITED_HISTORY_usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_h1379275121

- 種類: `REG_BINARY`

### SavedWorldSearchesusr_0b83d9be-9852-42dd-98e2-625062400acc_h1476758580

- 種類: `REG_BINARY`

### SavedWorldSearchesusr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_h166057949

- 種類: `REG_BINARY`

### Screenmanager Fullscreen mode Default_h401710285

- 種類: `REG_DWORD`

### Screenmanager Fullscreen mode_h3630240806

- 種類: `REG_DWORD`

### Screenmanager Resolution Height Default_h1380706816

- 種類: `REG_DWORD`

### Screenmanager Resolution Height_h2627697771

- 種類: `REG_DWORD`

ウィンドウの縦幅。なぜか *Screenmanager Resolution Window Height_h1684712807* と同じ。

### Screenmanager Resolution Use Native Default_h1405981789

- 種類: `REG_DWORD`

### Screenmanager Resolution Use Native_h1405027254

- 種類: `REG_DWORD`

### Screenmanager Resolution Width Default_h680557497

- 種類: `REG_DWORD`

### Screenmanager Resolution Width_h182942802

- 種類: `REG_DWORD`

ウィンドウの横幅

例: `dword:00000f00` → 3840 px

### Screenmanager Resolution Window Height_h1684712807

- 種類: `REG_DWORD`

ウィンドウの縦幅

例: `dword:00000806` → 2054 px

### Screenmanager Resolution Window Width_h2524650974

- 種類: `REG_DWORD`

ウィンドウの横幅。なぜか *Screenmanager Resolution Width_h182942802* と同じ。

### Screenmanager Stereo 3D_h1665754519

- 種類: `REG_DWORD`

### Screenmanager Window Position X_h4088080503

- 種類: `REG_DWORD`

ウィンドウの左上の X 座標

例: `dword:0000003c` → 60 px

### Screenmanager Window Position Y_h4088080502

- 種類: `REG_DWORD`

ウィンドウの左上の Y 座標

例: `dword:0000002b` → 43 px

### SeatedPlayEnabled_h2646878214

- 種類: `REG_DWORD`

### SeenIPS_SEEN_usr_0b83d9be-9852-42dd-98e2-625062400acc_h3505523105

- 種類: `REG_BINARY`

### SHADOW_QUALITY_h2860313905

- 種類: `REG_DWORD`

### SortSelection_AllFriends_h1381279904

- 種類: `REG_DWORD`

### SortSelection_Authored_h3555249524

- 種類: `REG_DWORD`

### SortSelection_Blocked_h3888781352

- 種類: `REG_DWORD`

### SortSelection_Fallbacks_h3930350111

- 種類: `REG_DWORD`

### SortSelection_Favorites_h377900519

- 種類: `REG_DWORD`

### SortSelection_FriendLocations_h3854527900

- 種類: `REG_DWORD`

### SortSelection_Group1_h288594318

- 種類: `REG_DWORD`

### SortSelection_Group2_h288594317

- 種類: `REG_DWORD`

### SortSelection_Group3_h288594316

- 種類: `REG_DWORD`

### SortSelection_GroupActivity_h1622071570

- 種類: `REG_DWORD`

### SortSelection_GroupLocations_h535141137

- 種類: `REG_DWORD`

### SortSelection_InRoom_h195141176

- 種類: `REG_DWORD`

### SortSelection_ips_58f6e3e2-98d1-44c4-987f-2d8856da3089_h2183212648

- 種類: `REG_DWORD`

### SortSelection_ips_af72a5e7-fa6e-4caa-a9f6-a1fbb550baea_h2919122043

- 種類: `REG_DWORD`

### SortSelection_LaunchPadRecentlyPlayedWith_h3038157937

- 種類: `REG_DWORD`

### SortSelection_LaunchPadRecentlyUpdatedAvatars_h457575329

- 種類: `REG_DWORD`

### SortSelection_LaunchPadRecentlyVistedWorlds_h1552254334

- 種類: `REG_DWORD`

### SortSelection_Offline_h1891691553

- 種類: `REG_DWORD`

### SortSelection_OnlineFriends_h3305609454

- 種類: `REG_DWORD`

### SortSelection_Other_h3401923396

- 種類: `REG_DWORD`

### SortSelection_Recent_Avatars_h1010646934

- 種類: `REG_DWORD`

### SortSelection_UGCAvatars_h76501747

- 種類: `REG_DWORD`

### SortSelection_UGCPlaylist1_h849225126

- 種類: `REG_DWORD`

### SortSelection_UGCPlaylist2_h849225125

- 種類: `REG_DWORD`

### SortSelection_UGCPlaylist3_h849225124

- 種類: `REG_DWORD`

### SortSelection_UGCPlaylist4_h849225123

- 種類: `REG_DWORD`

### SortSelection_UGCWorlds_h557164544

- 種類: `REG_DWORD`

### SortSelection_VRCPlus1_h4096808684

- 種類: `REG_DWORD`

### SortSelection_VRCPlus2_h4096808687

- 種類: `REG_DWORD`

### SortSelection_VRCPlus3_h4096808686

- 種類: `REG_DWORD`

### SortSelection_VRCPlus4_h4096808681

- 種類: `REG_DWORD`

### SortSelection_WorldInstances_h1863319032

- 種類: `REG_DWORD`

### SortSelection_Worlds_Playlist1_h440452697

- 種類: `REG_DWORD`

### SortSelection_Worlds_Playlist2_h440452698

- 種類: `REG_DWORD`

### SortSelection_Worlds_Playlist3_h440452699

- 種類: `REG_DWORD`

### SortSelection_Worlds_Playlist4_h440452700

- 種類: `REG_DWORD`

### SortSelection_Worlds_Uploaded_h3332849932

- 種類: `REG_DWORD`

### timeFormatIs12hrs_migrated_h1732113561

- 種類: `REG_DWORD`

### UI.MenuPlacementZDepthVR_h1362588766

- 種類: `REG_DWORD`

### UI.MotionSmoothingEnabled_h896528046

- 種類: `REG_DWORD`

### UI.RecentlyUsedEmojiNames_h680365886

- 種類: `REG_BINARY`

### UI.RecentlyUsedEmojiNames.Count_h2601255091

- 種類: `REG_DWORD`

### UI.RecentlyUsedEmojis_h997835737

- 種類: `REG_BINARY`

### UI.RecentlyUsedStickers_h4029642252

- 種類: `REG_BINARY`

### UI.RecentlyUsedStickers.Count_h970472129

- 種類: `REG_DWORD`

### UI.Settings.Osc_h1043380067

- 種類: `REG_DWORD`

### UI.usr_0b83d9be-9852-42dd-98e2-625062400acc.WingState_h2386885047

- 種類: `REG_BINARY`

### UI.usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481.WingState_h2631479838

- 種類: `REG_BINARY`

### unity.cloud_userid_h2665564582

- 種類: `REG_BINARY`
おそらく、[Unity のアナリティクス機能](https://docs.unity.com/ugs/en-us/manual/analytics/manual/overview) で付与されるユーザーの ID。

### unity.player_session_count_h922449978

- 種類: `REG_BINARY`

### unity.player_sessionid_h1351336811

- 種類: `REG_BINARY`

### UnityGraphicsQuality_h1669003810

- 種類: `REG_DWORD`

### UnitySelectMonitor_h17969598

- 種類: `REG_DWORD`

### USER_CAMERA_RESOLUTION_h3942642307

- 種類: `REG_BINARY`

### USER_CAMERA_ROLL_WHILE_FLYING_h3681714588

- 種類: `REG_DWORD`

### USER_CAMERA_STREAM_RESOLUTION_h3118717280

- 種類: `REG_DWORD`

### USER_CAMERA_TRIGGER_TAKES_PHOTOS_h2533461762

- 種類: `REG_DWORD`

### UserId_h2934586105

- 種類: `REG_BINARY`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_avatarProxyAlwaysShowExplicit_h824061901

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_avatarProxyAlwaysShowFriends_h2667156570

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_avatarProxyShowAtRange_h3995351264

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_avatarProxyShowAtRangeToggle_h2912139442

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_avatarProxyShowMaxNumber_h2879382365

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_BACKGROUND_MATERIAL_usr_0b83d9be-9852-42dd-98e2-625062400acc_h1644568607

- 種類: `REG_BINARY`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_currentShowMaxNumberOfAvatarsEnabled_h3273569127

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_GiftDropNoRefundAfterUsageAgreeToggle_h3628147625

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_LastExpiredSubscription_h1906017290

- 種類: `REG_BINARY`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_OpenedQuickMenu_h1701971991

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_OpenMenuHelpShownCount_h1570426188

- 種類: `REG_DWORD`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_UI.RecentlyUsedEmojis_h2825360712

- 種類: `REG_BINARY`

### usr_0b83d9be-9852-42dd-98e2-625062400acc_UI.RecentlyUsedStickers_h4003245853

- 種類: `REG_BINARY`

### usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_LastExpiredSubscription_h1218566499

- 種類: `REG_BINARY`

### usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_OpenedQuickMenu_h57464062

- 種類: `REG_DWORD`

### usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_OpenMenuHelpShownCount_h72192773

- 種類: `REG_DWORD`

### usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_PromotionData_h1998604222

- 種類: `REG_BINARY`

### usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_UI.RecentlyUsedEmojis_h2685023585

- 種類: `REG_BINARY`

### usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_UI.RecentlyUsedStickers_h2392842932

- 種類: `REG_BINARY`

### VRC_ACTION_MENU_FLICK_SELECT_h2064861260

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_L_HUD_ANGLE_X_h672500291

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_L_HUD_ANGLE_Y_h672500290

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_L_MENU_OPACITY_h4016404086

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_L_MENU_SIZE_PERCENTAGE_h3874913549

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_L_SHOW_ON_HUD_h4080424120

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_ONE_HAND_MOVE_h3374115622

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_R_HUD_ANGLE_X_h214254173

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_R_HUD_ANGLE_Y_h214254172

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_R_MENU_OPACITY_h2459220008

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_R_MENU_SIZE_PERCENTAGE_h2895102035

- 種類: `REG_DWORD`

### VRC_ACTION_MENU_R_SHOW_ON_HUD_h578424486

- 種類: `REG_DWORD`

### VRC_ADVANCED_GRAPHICS_ANTIALIASING_h4197584722

- 種類: `REG_DWORD`

### VRC_ADVANCED_GRAPHICS_QUALITY_h811609915

- 種類: `REG_BINARY`

### VRC_AFK_ENABLED_h2146228555

- 種類: `REG_DWORD`

### VRC_ALLOW_AVATAR_COPYING_h4277277104

- 種類: `REG_DWORD`

### VRC_ALLOW_DIRECT_SHARES_h4236543863

- 種類: `REG_DWORD`

### VRC_ALLOW_FOCUS_VIEW_h3187532037

- 種類: `REG_DWORD`

### VRC_ALLOW_PEDESTAL_SHARES_h3228887076

- 種類: `REG_DWORD`

### VRC_ALLOW_PRINTS_h1571139417

- 種類: `REG_DWORD`

### VRC_ALLOW_UNTRUSTED_URL_h3795044449

- 種類: `REG_DWORD`

### VRC_ANDROID_MIC_MODE_h4010114242

- 種類: `REG_DWORD`

### VRC_ASK_TO_PORTAL_h1103353099

- 種類: `REG_DWORD`

### VRC_AV_INTERACT_LEVEL_h3923676462

- 種類: `REG_DWORD`

### VRC_AV_INTERACT_SELF_h1940689668

- 種類: `REG_DWORD`

### VRC_AVATAR_FALLBACK_HIDDEN_h1331196586

- 種類: `REG_DWORD`

### VRC_AVATAR_HAPTICS_ENABLED_h221340797

- 種類: `REG_DWORD`

### VRC_AVATAR_MAXIMUM_DOWNLOAD_SIZE_h514967114

- 種類: `REG_DWORD`

### VRC_AVATAR_MAXIMUM_UNCOMPRESSED_SIZE_h1263307426

- 種類: `REG_DWORD`

### VRC_AVATAR_PERFORMANCE_RATING_MINIMUM_TO_DISPLAY_h1859707483

- 種類: `REG_DWORD`

### VRC_BLOOM_INTENSITY_h3753063118

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_ABOVE_HEAD_V2_h380784334

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_AUDIO_ENABLED_h2657302513

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_AUDIO_VOLUME_h3897769468

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_AUTO_SEND_h669043409

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_OPACITY_h1582266244

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_POS_HEIGHT_h4224194065

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_PROFANITY_FILTER_h3200174242

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_SCALE_h399529285

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_SHOW_OWN_h3999066263

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_TIMEOUT_h2984719174

- 種類: `REG_DWORD`

### VRC_CHAT_BUBBLE_VISIBILITY_h326857595

- 種類: `REG_DWORD`

### VRC_CLEAR_CACHE_ON_START_h1469307862

- 種類: `REG_DWORD`

### VRC_CLOCK_HOUR_MODE_h380910102

- 種類: `REG_DWORD`

### VRC_CLOCK_TIMEZONE_MODE_h1823781501

- 種類: `REG_DWORD`

### VRC_CLOCK_VARIANT_h1278072413

- 種類: `REG_DWORD`

### VRC_COLOR_BLINDNESS_SIMULATE_h1126230328

- 種類: `REG_DWORD`

### VRC_COLOR_FILTER_INTENSITY_h2776671055

- 種類: `REG_DWORD`

### VRC_COLOR_FILTER_SELECTION_h2218956640

- 種類: `REG_DWORD`

### VRC_COLOR_FILTER_TO_WORLD_h2345527878

- 種類: `REG_DWORD`

### VRC_COMFORT_MODE_h4074006575

- 種類: `REG_DWORD`

### VRC_COMFORT_MODE_PRE_HOLOPORT_h1923956789

- 種類: `REG_DWORD`

### VRC_CONVERT_ALL_DYNAMIC_BONES_h3703941876

- 種類: `REG_DWORD`

### VRC_CURRENT_LANGUAGE_h2382508793

- 種類: `REG_BINARY`

### VRC_DESKTOP_RETICLE_h2017415952

- 種類: `REG_DWORD`

### VRC_DIRECT_SHARING_VISIBILITY_h3852670846

- 種類: `REG_DWORD`

### VRC_DISABLE_AVATAR_CLONING_ON_ENTER_WORLD_h2378047106

- 種類: `REG_DWORD`

### VRC_DOUBLE_TAP_MAIN_MENU_STEAMVR2_h2259292525

- 種類: `REG_DWORD`

### VRC_DOWNLOAD_PRIORITIZE_DISTANCE_ENABLED_h370907117

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_AVATARS_h1388684338

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_CONE_VALUE_h3536705187

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_FALLOFF_h4143299544

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_FOLLOW_HEAD_h1009145430

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_h4050365647

- 種類: `REG_DWORD`

`Audit & Voice` の `Earmuff Mode` セクション内 `Earmuff Mode` の設定値。  
オフで `dword:00000000`、オンで `dword:00000001`

### VRC_EARMUFF_MODE_LOCK_ROTATION_h2094207696

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_OFFSET_VALUE_h248834185

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_RADIUS_h3767980936

- 種類: `REG_DWORD`

`Audit & Voice` の `Earmuff Mode` セクション内 `Distance` の設定値。  
データの詳細は [共通のデータ > 距離](#common-distance) を参照。

### VRC_EARMUFF_MODE_REDUCED_VOLUME_h3523741539

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_SHOW_ICON_IN_NAMEPLATE_h2773945451

- 種類: `REG_DWORD`

### VRC_EARMUFF_MODE_VISUAL_AIDE_h1038948562

- 種類: `REG_DWORD`

### VRC_FINGER_GRAB_SETTING_h3527088908

- 種類: `REG_DWORD`

### VRC_FINGER_HAPTIC_SENSITIVITY_h3615339142

- 種類: `REG_DWORD`

### VRC_FINGER_HAPTIC_STRENGTH_h3232094030

- 種類: `REG_DWORD`

### VRC_FINGER_JUMP_ENABLED_h3477451755

- 種類: `REG_DWORD`

### VRC_FINGER_WALK_SETTING_h2794929451

- 種類: `REG_DWORD`

### VRC_FINGERTRACKING_AVATARS_USE_h1326086178

- 種類: `REG_DWORD`

### VRC_FINGERTRACKING_SHOW_PINCHUI_h1008817888

- 種類: `REG_DWORD`

### VRC_FINGERTRACKING_USE_EXCLUSIVE_h3085905998

- 種類: `REG_DWORD`

### VRC_FINGERTRACKING_USE_GHOSTHAND_h1274811204

- 種類: `REG_DWORD`

### VRC_GESTURE_BAR_ENABLED_h2747941422

- 種類: `REG_DWORD`

### VRC_GROUP_ON_NAMEPLATE_h939169640

- 種類: `REG_BINARY`

### VRC_GROUP_ORDER_usr_0b83d9be-9852-42dd-98e2-625062400acc_h2546210946

- 種類: `REG_BINARY`

### VRC_GROUP_ORDER_usr_bfab80de-44d5-42f7-9d22-f6e3a7da1481_h731998507

- 種類: `REG_BINARY`

### VRC_HANDS_MENU_OPEN_MODE_h2533652086

- 種類: `REG_DWORD`

### VRC_HIDE_NOTIFICATION_PHOTOS_h4294716079

- 種類: `REG_DWORD`

### VRC_HOME_ACCESS_TYPE_h350155342

- 種類: `REG_DWORD`

### VRC_HOME_REGION_h1998217749

- 種類: `REG_DWORD`

### VRC_HUD_ANCHOR_h3164134786

- 種類: `REG_DWORD`

### VRC_HUD_MIC_OPACITY_h3335237114

- 種類: `REG_DWORD`

### VRC_HUD_MODE_h3039617176

- 種類: `REG_DWORD`

### VRC_HUD_OPACITY_h1221709026

- 種類: `REG_DWORD`

### VRC_HUD_SMOOTHING_Desktop_h2589019796

- 種類: `REG_DWORD`

### VRC_HUD_SMOOTHING_VR_h2714590178

- 種類: `REG_DWORD`

### VRC_IK_AVATAR_MEASUREMENT_TYPE_h2850617027

- 種類: `REG_DWORD`

### VRC_IK_CALIBRATION_RANGE_h210545898

- 種類: `REG_DWORD`

### VRC_IK_CALIBRATION_VIS_h4101902745

- 種類: `REG_DWORD`

### VRC_IK_DEBUG_LOGGING_h1722378125

- 種類: `REG_DWORD`

### VRC_IK_DISABLE_SHOULDER_TRACKING_h902380709

- 種類: `REG_DWORD`

### VRC_IK_FBT_CONFIRM_CALIBRATE_h265409733

- 種類: `REG_DWORD`

### VRC_IK_FBT_LOCOMOTION_h2043840926

- 種類: `REG_DWORD`

### VRC_IK_FBT_SPINE_MODE_h4000002034

- 種類: `REG_DWORD`

### VRC_IK_FREEZE_TRACKING_ON_DISCONNECT_h3383048186

- 種類: `REG_DWORD`

### VRC_IK_HEIGHT_RATIO_h3129706017

- 種類: `REG_DWORD`

### VRC_IK_KNEE_ANGLE_h3772330779

- 種類: `REG_DWORD`

### VRC_IK_LEGACY_CALIBRATION_h3326892512

- 種類: `REG_DWORD`

### VRC_IK_LEGACY_h1928383989

- 種類: `REG_DWORD`

### VRC_IK_ONE_HANDED_CALIBRATION_h1441143116

- 種類: `REG_DWORD`

### VRC_IK_PER_AVATAR_CALIBRATION_ADJUSTMENT_h3760727148

- 種類: `REG_DWORD`

### VRC_IK_SHOULDER_WIDTH_COMPENSATION_h2128578700

- 種類: `REG_DWORD`

### VRC_IK_TRACKER_MODEL_h2318382088

- 種類: `REG_DWORD`

### VRC_IK_USE_METRIC_HEIGHT_h3069935960

- 種類: `REG_DWORD`

### VRC_IK_WRIST_ANGLE_h3558076085

- 種類: `REG_DWORD`

### VRC_IMPOSTOR_WHEN_AVAILABLE_h287131121

- 種類: `REG_DWORD`

### VRC_INPUT_COMFORT_TURNING_h2182102264

- 種類: `REG_DWORD`

### VRC_INPUT_CONTROLLER_h520919816

- 種類: `REG_DWORD`

### VRC_INPUT_DAYDREAM_h413117399

- 種類: `REG_DWORD`

### VRC_INPUT_DISABLE_MIC_BUTTON_h1777337009

- 種類: `REG_DWORD`

### VRC_INPUT_EMBODIED_h369838749

- 種類: `REG_DWORD`

### VRC_INPUT_GAZE_h2077319149

- 種類: `REG_DWORD`

### VRC_INPUT_GENERIC_h1962514789

- 種類: `REG_DWORD`

### VRC_INPUT_HEAD_LOOK_WALK_h2397876010

- 種類: `REG_DWORD`

### VRC_INPUT_HPMOTION_h190123858

- 種類: `REG_DWORD`

### VRC_INPUT_LOCOMOTION_METHOD_h1414739397

- 種類: `REG_DWORD`

### VRC_INPUT_MIC_DEVICE_NAME_Desktop_h2596021377

- 種類: `REG_BINARY`

デスクトップモードにおける `Audit & Voice` の `Microphone` セクション内 `Current Device` の設定値。  
System Default の場合は `hex:00`、デバイスを選んだ場合は、そのデバイス名がバイナリで保存される。

例: `マイク (Virtual Desktop Audio)` の場合は、`hex:e3,83,9e,e3,82,a4,e3,82,af,20,28,56,69,72,74,75,61,6c,20,44,65,73,6b,74,6f,70,20,41,75,64,69,6f,29,00`

### VRC_INPUT_MIC_DEVICE_NAME_VR_h2729556311

- 種類: `REG_BINARY`

### VRC_INPUT_MIC_ENABLED_h1348812137

- 種類: `REG_DWORD`

### VRC_INPUT_MIC_LEVEL_DESK_h3150270844

- 種類: `REG_DWORD`

`Audit & Voice` の `Microphone` セクション内 `Mic Output Volumes` の設定値。データの詳細は [共通のデータ > パーセンテージ](#common-percentage) を参照。

### VRC_INPUT_MIC_LEVEL_VR_h1442437185

- 種類: `REG_DWORD`

### VRC_INPUT_MIC_MODE_h2152931183

- 種類: `REG_DWORD`

`Audit & Voice` の `Microphone` セクション内 `Microphone Behavior` の設定値。

調査時は次のように変化した。

| ゲーム内設定値 | レジストリデータ |
| :- | :- |
| Push to Talk | `dword:00000000` |
| Toggle | `dword:00000001` |
| Always On | `dword:00000002` |
| Always Off | `dword:00000003` |

### VRC_INPUT_MIC_NOISE_GATE_h1714811770

- 種類: `REG_DWORD`

`Audit & Voice` の `Microphone` セクション内 `Mic Activation Threshold` の設定値。データの詳細は [共通のデータ > パーセンテージ](#common-percentage) を参照。

### VRC_INPUT_MIC_NOISE_SUPPRESSION_h2093770996

- 種類: `REG_DWORD`

`Audit & Voice` の `Microphone` セクション内 `Noise Suppression` の設定値。  
オフで `dword:00000000`、オンで `dword:00000001`

### VRC_INPUT_MIC_ON_JOIN_h1952602480

- 種類: `REG_DWORD`

### VRC_INPUT_MOBILE_INTERACTION_MODE_h2241581933

- 種類: `REG_DWORD`

### VRC_INPUT_OPENXR_h3348095050

- 種類: `REG_DWORD`

### VRC_INPUT_OSC_h1104161515

- 種類: `REG_DWORD`

### VRC_INPUT_PERSONAL_SPACE_h2484208791

- 種類: `REG_DWORD`

### VRC_INPUT_QUEST_HANDS_h4125242269

- 種類: `REG_DWORD`

### VRC_INPUT_SELECTED_SAFETY_RANK_h2383440951

- 種類: `REG_BINARY`

### VRC_INPUT_SHOW_TOOLTIPS_h2626405966

- 種類: `REG_DWORD`

### VRC_INPUT_STEAMVR2_h3800904780

- 種類: `REG_DWORD`

### VRC_INPUT_TALK_DEFAULT_ON_h3020434060

- 種類: `REG_DWORD`

### VRC_INPUT_TALK_TOGGLE_h4177681451

- 種類: `REG_DWORD`

### VRC_INPUT_THIRD_PERSON_ROTATION_h1300348630

- 種類: `REG_DWORD`

### VRC_INPUT_TOUCH_h4109827025

- 種類: `REG_DWORD`

### VRC_INPUT_TOUCHSCREEN_h3394817245

- 種類: `REG_DWORD`

### VRC_INPUT_VALVE_INDEX_h3652608509

- 種類: `REG_DWORD`

### VRC_INPUT_VIVE_ADVANCED_h1503440857

- 種類: `REG_DWORD`

### VRC_INPUT_VIVE_h2076719896

- 種類: `REG_DWORD`

### VRC_INPUT_VOICE_PRIORITIZATION_h33056792

- 種類: `REG_DWORD`

### VRC_INPUT_WAVE_h2076745073

- 種類: `REG_DWORD`

### VRC_INTERACT_HAPTICS_ENABLED_h3393058910

- 種類: `REG_DWORD`

### VRC_INVERTED_MOUSE_h371555472

- 種類: `REG_DWORD`

### VRC_LANDSCAPE_FOV_h3103793630

- 種類: `REG_DWORD`

### VRC_LIMIT_DYNAMIC_BONE_USAGE_h3028750113

- 種類: `REG_DWORD`

### VRC_LIMIT_PARTICLE_SYSTEMS_h1481531850

- 種類: `REG_DWORD`

### VRC_MAIN_MENU_MOVEMENT_LOCKED_h1046269715

- 種類: `REG_DWORD`

### VRC_MIC_ICON_VISIBILITY_h2339236183

- 種類: `REG_DWORD`

`Audit & Voice` の `Microphone` セクション内 `Mic Icon Visibility` の設定値。

調査時は次のように変化した。

| ゲーム内設定値 | レジストリデータ |
| :- | :- |
| Always On | `dword:00000000` |
| On Activity | `dword:00000001` |
| When Muted | `dword:00000002` |

### VRC_MIC_TOGGLE_VOLUME_h863439808

- 種類: `REG_DWORD`

### VRC_MIRROR_RESOLUTION_h4279880629

- 種類: `REG_DWORD`

### VRC_MM_FREE_PLACEMENT_ENABLED_h18715258

- 種類: `REG_DWORD`

### VRC_MOBILE_AUTO_HOLD_ENABLED_h4020356327

- 種類: `REG_DWORD`

### VRC_MOBILE_AUTO_WALK_ENABLED_h3465067929

- 種類: `REG_DWORD`

### VRC_MOBILE_DPI_SCALING_h3654096573

- 種類: `REG_DWORD`

### VRC_MOBILE_NOTIFICATIONS_SERVICE_ENABLED_h1282430308

- 種類: `REG_DWORD`

### VRC_MOBILE_PERFORMANCE_SECONDARY_UI_ENABLED_h1810506022

- 種類: `REG_DWORD`

### VRC_MOBILE_QUICK_SELECT_ENABLED_h4199380106

- 種類: `REG_DWORD`

### VRC_MOUSE_SENSITIVITY_h864189870

- 種類: `REG_DWORD`

### VRC_NAMEPLATE_FALLBACK_ICON_VISIBLE_h1423137440

- 種類: `REG_DWORD`

### VRC_NAMEPLATE_MODE_h1996516522

- 種類: `REG_DWORD`

### VRC_NAMEPLATE_OPACITY_h3607418576

- 種類: `REG_DWORD`

### VRC_NAMEPLATE_QUICK_MENU_INFO_h2920495537

- 種類: `REG_DWORD`

### VRC_NAMEPLATE_SCALE_V2_h191075274

- 種類: `REG_DWORD`

### VRC_NAMEPLATE_STATUS_MODE_h3911907425

- 種類: `REG_DWORD`

### VRC_ONLY_SHOW_FRIEND_JOIN_LEAVE_PORTAL_NOTIFICATIONS_h2041396875

- 種類: `REG_DWORD`

### VRC_PEDESTAL_SHARING_VISIBILITY_h1567854125

- 種類: `REG_DWORD`

### VRC_PLAY_NOTIFICATION_AUDIO_h3787789186

- 種類: `REG_DWORD`

### VRC_PLAYER_GESTURE_TOGGLE_h2603271707

- 種類: `REG_DWORD`

### VRC_PORTAL_MODE_V2_h1207488718

- 種類: `REG_DWORD`

### VRC_PORTRAIT_FOV_h2841329674

- 種類: `REG_DWORD`

### VRC_PRINT_VISIBILITY_h2092280245

- 種類: `REG_DWORD`

### VRC_PRIORITIZE_DOWNLOAD_DISTANCE_h554120599

- 種類: `REG_DWORD`

### VRC_PRIORITIZE_FRIEND_DOWNLOADS_h2668632341

- 種類: `REG_DWORD`

### VRC_PRIORITIZE_MANUAL_DOWNLOADS_h627057341

- 種類: `REG_DWORD`

### VRC_SAFETY_LEVEL_h215562216

- 種類: `REG_DWORD`

### VRC_SCREEN_BRIGHTNESS_h779104839

- 種類: `REG_DWORD`

### VRC_SCREEN_CONTRAST_h3918435212

- 種類: `REG_DWORD`

### VRC_SELECTED_NETWORK_REGION_h4193729042

- 種類: `REG_DWORD`

### VRC_SHOW_COMMUNITY_LAB_WORLDS_IN_SEARCH_h2234095397

- 種類: `REG_DWORD`

### VRC_SHOW_COMMUNITY_LABS_h939850385

- 種類: `REG_DWORD`

### VRC_SHOW_COMPATIBILITY_WARNINGS_h1338583913

- 種類: `REG_DWORD`

### VRC_SHOW_FRIEND_REQUESTS_h4086929838

- 種類: `REG_DWORD`

### VRC_SHOW_GO_BUTTON_IN_LOAD_h2825223361

- 種類: `REG_DWORD`

### VRC_SHOW_GROUP_BADGE_TO_OTHERS_h3326692840

- 種類: `REG_DWORD`

### VRC_SHOW_GROUP_BADGES_h3905607703

- 種類: `REG_DWORD`

### VRC_SHOW_INVITES_NOTIFICATION_h2044224361

- 種類: `REG_DWORD`

### VRC_SHOW_JOIN_NOTIFICATIONS_h3231893122

- 種類: `REG_DWORD`

### VRC_SHOW_LEAVE_NOTIFICATIONS_h890489659

- 種類: `REG_DWORD`

### VRC_SHOW_PORTAL_NOTIFICATIONS_h3954406036

- 種類: `REG_DWORD`

### VRC_SHOW_SOCIAL_RANK_h197998419

- 種類: `REG_DWORD`

### VRC_SLIDER_SNAPPING_h372519771

- 種類: `REG_DWORD`

### VRC_STREAMER_MODE_ENABLED_h2220544112

- 種類: `REG_DWORD`

### VRC_TOUCH_AUTO_ROTATE_SPEED_h1407864758

- 種類: `REG_DWORD`

### VRC_TOUCH_SENSITIVITY_h4266013482

- 種類: `REG_DWORD`

### VRC_TRACKING_CAN_SHOW_SELFIE_FACE_TRACKING_POPUP_h634119785

- 種類: `REG_DWORD`

### VRC_TRACKING_DISABLE_EYELIDTRACKING_h3930116433

- 種類: `REG_DWORD`

### VRC_TRACKING_DISABLE_EYELOOKTRACKING_h4116852663

- 種類: `REG_DWORD`

### VRC_TRACKING_DISABLE_EYETRACKING_ON_MUTE_h673004696

- 種類: `REG_DWORD`

### VRC_TRACKING_DISPLAY_EYETRACKING_DEBUG_h2989052272

- 種類: `REG_DWORD`

### VRC_TRACKING_ENABLE_SELFIE_FACE_TRACKING_AUTO_QUALITY_h748720975

- 種類: `REG_DWORD`

### VRC_TRACKING_ENABLE_SELFIE_FACE_TRACKING_h4230842765

- 種類: `REG_DWORD`

### VRC_TRACKING_FORCE_EYETRACKING_RAYCAST_h804437833

- 種類: `REG_DWORD`

### VRC_TRACKING_NUM_TIMES_DISABLED_SELFIE_FACE_TRACKING_h1237361804

- 種類: `REG_DWORD`

### VRC_TRACKING_NUM_TIMES_ENABLED_SELFIE_FACE_TRACKING_h1097066617

- 種類: `REG_DWORD`

### VRC_TRACKING_NUM_TIMES_REFUSED_SELFIE_FACE_TRACKING_POPUP_h624633215

- 種類: `REG_DWORD`

### VRC_TRACKING_SELFIE_FACE_TRACKING_QUALITY_LEVEL_h552326824

- 種類: `REG_DWORD`

### VRC_TRACKING_SEND_VR_SYSTEM_HEAD_AND_WRIST_OSC_DATA_h4205805416

- 種類: `REG_DWORD`

### VRC_TRACKING_SHOULD_SHOW_OSC_TRACKING_DATA_REMINDER_h1197116246

- 種類: `REG_DWORD`

### VRC_TRACKING_TRACKER_PREDICTION_h717710431

- 種類: `REG_DWORD`

### VRC_UI_HAPTICS_ENABLED_h3454413680

- 種類: `REG_DWORD`

### VRC_UI_HEADER_CLICK_SCROLL_RESET_ENABLED_h3974911282

- 種類: `REG_DWORD`

### VRC_USE_COLOR_FILTER_h409466403

- 種類: `REG_DWORD`

### VRC_USE_OUTLINE_MIC_ICON_h3135516813

- 種類: `REG_DWORD`

### VRC_USE_PIXEL_SHIFTING_HUD_h2883719856

- 種類: `REG_DWORD`

### VRC_VR_AUTO_HOLD_ENABLED_h4280497987

- 種類: `REG_DWORD`

### VRC_WING_PERSISTENCE_ENABLED_h2157755736

- 種類: `REG_DWORD`

### VRC_WORLD_TOOLTIP_MODE_h184416713

- 種類: `REG_DWORD`

### VRC.UI.QuickMenu.ShowQMDebugInfo_h1745736838

- 種類: `REG_DWORD`

### Wing_Left_Groups_Selected_Group_h1988611443

- 種類: `REG_BINARY`

### Wing_Right_Avatars_Category_h136079647

- 種類: `REG_BINARY`

### Wing_Right_Avatars_SortBy_h1990609358

- 種類: `REG_BINARY`

### Wing_Right_Friends_Category_h3292643868

- 種類: `REG_BINARY`

### Wing_Right_Friends_SortBy_h3336145741

- 種類: `REG_BINARY`

### Wing_Right_Groups_Selected_Group_h550996744

- 種類: `REG_BINARY`

## 共通のデータ

### パーセンテージ {: #common-percentage }

| ゲーム内設定値 | レジストリデータ |
| :- | :- |
| 0% | `hex(4):00,00,00,00,00,00,00,00` |
| 5% | `hex(4):00,00,00,a0,99,99,a9,3f` |
| 10% | `hex(4):00,00,00,a0,99,99,b9,3f` |
| 15% | `hex(4):00,00,00,40,33,33,c3,3f` |
| 20% | `hex(4):00,00,00,a0,99,99,c9,3f` |
| 25% | `hex(4):00,00,00,00,00,00,d0,3f` |
| 30% | `hex(4):00,00,00,40,33,33,d3,3f` |
| 35% | `hex(4):00,00,00,60,66,66,d6,3f` |
| 40% | `hex(4):00,00,00,a0,99,99,d9,3f` |
| 45% | `hex(4):00,00,00,e0,cc,cc,dc,3f` |
| 50% | `hex(4):00,00,00,00,00,00,e0,3f` |
| 55% | `hex(4):00,00,00,a0,99,99,e1,3f` |
| 60% | `hex(4):00,00,00,40,33,33,e3,3f` |
| 65% | `hex(4):00,00,00,e0,cc,cc,e4,3f` |
| 70% | `hex(4):00,00,00,60,66,66,e6,3f` |
| 75% | `hex(4):00,00,00,00,00,00,e8,3f` |
| 80% | `hex(4):00,00,00,a0,99,99,e9,3f` |
| 85% | `hex(4):00,00,00,40,33,33,eb,3f` |
| 90% | `hex(4):00,00,00,e0,cc,cc,ec,3f` |
| 95% | `hex(4):00,00,00,60,66,66,ee,3f` |
| 100% | `hex(4):00,00,00,00,00,00,f0,3f` |

### 距離 {: #common-distance }

長いので一部を省略します。

| ゲーム内設定値 | レジストリデータ |
| :- | :- |
| 0.0m | `hex(4):00,00,00,00,00,00,00,00` |
| 0.1m | `hex(4):00,00,00,a0,99,99,b9,3f` |
| 0.2m | `hex(4):00,00,00,40,33,33,c3,3f` |
| 0.3m | `hex(4):00,00,00,40,33,33,d3,3f` |
| 0.4m | `hex(4):00,00,00,a0,99,99,e1,3f` |
| 0.5m | `hex(4):00,00,00,e0,cc,cc,dc,3f` |
| 0.6m | `hex(4):00,00,00,40,33,33,e3,3f` |
| 0.7m | `hex(4):00,00,00,00,00,00,e8,3f` |
| 0.8m | `hex(4):00,00,00,a0,99,99,e9,3f` |
| 0.9m | `hex(4):00,00,00,e0,cc,cc,ec,3f` |
| 1.0m | `hex(4):00,00,00,60,66,66,ee,3f` |
| ... | ... |
| 9.0m | `hex(4):00,00,00,00,00,00,22,40` |
| 9.1m | `hex(4):33,33,33,33,33,33,22,40` |
| 9.2m | `hex(4):66,66,66,66,66,66,22,40` |
| 9.3m | `hex(4):9a,99,99,99,99,99,22,40` |
| 9.4m | `hex(4):cd,cc,cc,cc,cc,cc,22,40` |
| 9.5m | `hex(4):00,00,00,00,00,00,23,40` |
| 9.6m | `hex(4):33,33,33,33,33,33,23,40` |
| 9.7m | `hex(4):66,66,66,66,66,66,23,40` |
| 9.8m | `hex(4):9a,99,99,99,99,99,23,40` |
| 9.9m | `hex(4):cd,cc,cc,cc,cc,cc,23,40` |
| 10.0m | `hex(4):00,00,00,00,00,00,24,40` |

以下の Python スクリプトですべてのパターンを出力できる。  
浮動小数点数を IEEE 754 形式の倍精度実数での 16 進数に変換してあげればよさそう。

https://gist.github.com/book000/46b59268e6836baffdb7faa6c4fc1c8e#file-calculate-vrchat-distance-registory-data-py
