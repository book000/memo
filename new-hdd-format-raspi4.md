# Raspberry Pi 4 model B で新しい HDD をフォーマット & マウントする

## 1. HDD を接続する

ラズパイをシャットダウンしたあと、外付け HDD を繋いで起動する

## 2. 対象 HDD のデバイスファイルを調べる

`sudo dmesg` や `sudo fdisk -l` で接続した HDD のデバイスファイルを調べる。  

```shell
tomachi@tomapi:~ $ sudo fdisk -l
Device         Boot  Start      End  Sectors  Size Id Type
/dev/mmcblk0p1        8192   532479   524288  256M  c W95 FAT32 (LBA)
/dev/mmcblk0p2      532480 61157375 60624896 28.9G 83 Linux


Disk /dev/sda: 5.5 TiB, 6001175126016 bytes, 11721045168 sectors
Disk model: Generic
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/sdb: 2.7 TiB, 3000592982016 bytes, 5860533168 sectors
Disk model: Generic
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: C6BC8787-E4F4-49AB-8795-BC0DC6962A6B

Device     Start        End    Sectors  Size Type
/dev/sdb1  65535 5860533134 5860467600  2.7T Linux filesystem

Partition 1 does not start on physical sector boundary.
```

`df -h` とかと見比べながら、既存 HDD と間違えないように確認する。ここでは 5.5 TiB の `/dev/sda` が対象なので、それに対して操作する。

<details>
<summary>※ 2 TB 未満の場合は MBR でフォーマットするのでこちらを参照</summary>

※間違えて 6TB HDD なのに MBR でフォーマットしたのでとりあえず残しておく

## 3. パーティションを作成する

`fdisk` で HDD にパーティションを作成する。

1. `Command (m for help)` では、新しいパーティションを作るので `NEW` -> `n` を入れる
2. `Partition type` では、プライマリの基本領域を作成するので `p` を入れる (そのまま Enter でも可)
3. `Partition number` では、初めてのパーティションなので `1` を入れる (そのまま Enter でも可)
4. `Created a new partition` と出たら成功
5. `Command (m for help)` に戻るので、実施した内容を HDD に書き込むために `WRITE` -> `w` を入れる
6. 正常に書き込まれてシェルが戻ってきたら成功

```shell
tomachi@tomapi:~ $ sudo fdisk /dev/sda

Welcome to fdisk (util-linux 2.33.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
The size of this disk is 5.5 TiB (6001175126016 bytes). DOS partition table format cannot be used on drives for volumes larger than 4294966784 bytes for 512-byte sectors. Use GUID partition table format (GPT).

Created a new DOS disklabel with disk identifier 0x28e4f28c.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-4294967295, default 2048): 2048
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-4294967294, default 4294967294):

Created a new partition 1 of type 'Linux' and of size 2 TiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

`sudo fdisk -l /dev/sda` で先ほど実施したパーティション作成が正常に完了したかを確認する。

```shell
tomachi@tomapi:~ $ sudo fdisk -l /dev/sda
Disk /dev/sda: 5.5 TiB, 6001175126016 bytes, 11721045168 sectors
Disk model: Generic
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: dos
Disk identifier: 0x28e4f28c

Device     Boot Start        End    Sectors Size Id Type
/dev/sda1        2048 4294967294 4294965247   2T 83 Linux
```

正常に作成できていることを確認。
</details>

以下、2TB 以上の場合（GPT で作成）

## 3. パーティションを作成する

GPT で作るので、`parted` コマンドを使う。

1. `p` で現状のパーティション状態を確認する
2. GPT でフォーマットしたいのでラベルを GPT にする: `mklabel gpt`
3. 再度 `p` で `Partition Table` が `gpt` であることを確認する
4. `mkpart` でパーティションを作成する。ここで渡すパラメータはサイトによって異なるので、適切なパラメータを確認したほうが良い  
   [この記事](https://kiyoshi.hatenablog.com/entry/20131228/1388157792) では `mkpart primary ext4 0 -0` すれば問題ないとあったけど `Error: Unable to satisfy all constraints on the partition.` と怒られるし、  
   [この記事](https://qiita.com/ktateish/items/238c03f28e8b3335f684) では `parted` 実行時に `-a optimal` を付けたうえで `mkpart primary ext4 0% 100%` すれば良いとあるけど、これも上記エラーが出るし、  
   今回のパラメータも `Warning: The resulting partition is not properly aligned for best performance.` と出るのでよくわからない。
5. 再度 `p` で 正常にパーティションが作成されたことを確認する
6. `q` で抜ける

```shell
tomachi@tomapi:~ $ sudo parted /dev/sda
GNU Parted 3.2
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Model: JMicron Generic (scsi)
Disk /dev/sda: 6001GB
Sector size (logical/physical): 512B/4096B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  2199GB  2199GB  primary

(parted) mklabel gpt
Warning: The existing disk label on /dev/sda will be destroyed and all data on this disk will be lost. Do you want to continue?
Yes/No? y
(parted) p
Model: JMicron Generic (scsi)
Disk /dev/sda: 6001GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags:

Number  Start  End  Size  File system  Name  Flags

(parted) mkpart primary ext4 0 6001GB
Warning: The resulting partition is not properly aligned for best performance.
Ignore/Cancel? i

(parted) p
Model: JMicron Generic (scsi)
Disk /dev/sda: 6001GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system  Name     Flags
 1      17.4kB  6001GB  6001GB  ext4         primary

(parted) q

Information: You may need to update /etc/fstab.
```

### 4. フォーマットを行う

`mkfs` でフォーマットを行う。

```shell
tomachi@tomapi:~ $ sudo mkfs -t ext4 /dev/sda1
mke2fs 1.44.5 (15-Dec-2018)
/dev/sda1 alignment is offset by 3072 bytes.
This may result in very poor performance, (re)-partitioning suggested.
Creating filesystem with 1465130637 4k blocks and 183144448 inodes
Filesystem UUID: 67269083-355d-422c-85b7-8a4744fe2c25
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
        102400000, 214990848, 512000000, 550731776, 644972544

Allocating group tables: done
Writing inode tables: done
Creating journal (262144 blocks): done
Writing superblocks and filesystem accounting information: done
```

### 5. マウントする

対象のディレクトリを作成した後、マウントする。

```shell
tomachi@tomapi:~ $ sudo mkdir /3rdhdd
tomachi@tomapi:~ $ sudo mount -t ext4 /dev/sda1 /3rdhdd
```

### 6. マウントされているかの確認

`df -h` で確認。

```shell
tomachi@tomapi:~ $ df -h
Filesystem                 Size  Used Avail Use% Mounted on
/dev/root                   29G   15G   14G  52% /
/dev/sdb1                  2.7T  2.2T  414G  85% /subhdd
/dev/sda1                  5.5T   89M  5.2T   1% /3rdhdd
```

### 7. 再起動してもマウントするように /etc/fstab に記述

デバイスファイルで指定するとディスクの認識順番でおかしくなる場合があるので、UUID でマウントする

まず、パーティションの UUID を確認

```shell
tomachi@tomapi:~ $ ls -l /dev/disk/by-uuid/
total 0
lrwxrwxrwx 1 root root 10 Nov  9 18:29 67269083-355d-422c-85b7-8a4744fe2c25 -> ../../sda1
```

`67269083-355d-422c-85b7-8a4744fe2c25` であることが分かる。

`/etc/fstab` に以下のように追記する

```diff
--- fstab.old
+++ /etc/fstab
 tmpfs /var/tmp tmpfs defaults,size=300m,noatime,mode=1777 0 0
+UUID="67269083-355d-422c-85b7-8a4744fe2c25" /3rdhdd ext4 defaults 0 0
```
