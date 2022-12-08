/*
MIT License

Copyright (c) 2021 Tomachi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

MHT ファイルをパースするための TypeScript ライブラリ。

libmime: 5.0.0
quoted-printable: 1.0.1
*/

/* eslint-disable import/no-named-as-default-member */
import libmime from 'libmime'
import quotedPrintable from 'quoted-printable'
import utf8 from 'utf8'

/**
 * 各ファイルのオブジェクトクラス
 *
 * 各ファイルは「パート」という単位名で管理されます。
 * mhtファイルは複数の「パート」で構成されており、1ファイルにエンコードされたHTMLやエンコードされた画像ファイルなどが含まれています。
 * このクラスでは、個々のパートをオブジェクトとしクラス管理します。
 */
export class MhtmlPart {
  private _name: string
  private _headers: Map<string, string> = new Map<string, string>()
  private _content: string | Buffer | undefined = undefined

  constructor(name: string) {
    this._name = name
  }

  /**
   * パート名
   *
   * これは、パートの識別名です。NextPart_000_0000_5182A7576.184A69831 などとなります。
   * 一般的に、これは使用されません。
   */
  get name(): string {
    return this._name
  }

  /**
   * ヘッダー（ゲッター）
   *
   * パートのヘッダーを返します。
   *
   * ヘッダーは、パートの情報をキーバリュー形式で管理するものです。
   * ヘッダーには元々のパスを示す Content-Location や、ファイルのMIMEタイプを示す Content-Type などが含まれています。
   */
  get headers(): Map<string, string> {
    return this._headers
  }

  /**
   * ヘッダー（セッター）
   *
   * 前述したヘッダーをオブジェクトに対し設定する関数です。
   */
  set headers(headers: Map<string, string>) {
    this._headers = headers
  }

  /**
   * ヘッダー項目を追加する
   *
   * ヘッダーに項目を追加する関数です。
   *
   * @param key ヘッダーキー
   * @param value ヘッダー値
   */
  public addHeader(key: string, value: string): void {
    this._headers.set(key, value)
  }

  /**
   * コンテンツ
   *
   * パートのコンテンツを返します。
   *
   * コンテンツには、HTMLや画像バイナリなどのデータが含まれています。
   * mhtファイルではこれらのコンテンツはエンコードされていますが、この関数ではエンコードされていない状態（デコード済み）で返します。
   */
  get content(): string | Buffer | undefined {
    return this._content
  }

  /**
   * コンテンツ
   *
   * パートのコンテンツを設定する関数です。
   *
   * コンテンツ設定時はデコードした状態で設定してください。
   */
  set content(content: string | Buffer | undefined) {
    this._content = content
  }
}

/**
 * 「目次」の項目オブジェクトクラス
 *
 * コースコンテンツなど、複数のページで構成される場合にはトップページ以外にもページが生成されます。
 * このオブジェクトでは、目次の項目を管理します。
 */
class MToc {
  private _title: string
  private _url: string
  private _part: MhtmlPart

  constructor(title: string, url: string, part: MhtmlPart) {
    this._title = title
    this._url = url
    this._part = part
  }

  /**
   * タイトル
   *
   * 目次の項目のタイトルを返します。
   */
  get title(): string {
    return this._title
  }

  /**
   * URL
   *
   * 目次の項目のURLを返します。
   */
  get url(): string {
    return this._url
  }

  /**
   * パート
   *
   * 目次の項目のパートデータを返します。
   */
  get part(): MhtmlPart {
    return this._part
  }
}

/**
 * mhtファイルをパースした結果のオブジェクトクラス
 *
 * mhtファイルをパースした結果を格納したオブジェクトです。
 */
export class Mhtml {
  /** ヘッダー */
  readonly headers: Map<string, string>
  /** トップコンテンツ（これは基本 This is	a multi-part message in	MIME format. だけです） */
  readonly contents: string
  /** 目次項目一覧 */
  readonly toc: MToc[] | null
  /** パート一覧 */
  readonly parts: MhtmlPart[] = []

  constructor(
    headers: Map<string, string>,
    contents: string,
    toc: MToc[] | null,
    parts: MhtmlPart[]
  ) {
    this.headers = headers
    this.contents = contents
    this.toc = toc
    this.parts = parts
  }
}

/**
 * ヘッダーをパースする
 *
 * @param map ヘッダーのキーバリュー形式のマップ
 * @param tempKey ヘッダーのキー
 * @param line ヘッダーの行
 * @returns [更新されたヘッダーのキーバリュー形式のマップ, 更新されたヘッダーのキー]
 */
function processHeader(
  map: Map<string, string>,
  tempKey: string,
  line: string
): [Map<string, string>, string] {
  if (line.startsWith('\t')) {
    map.set(
      tempKey,
      libmime.decodeWords(map.get(tempKey) + '\r\n' + line.trim())
    )
  } else if (line.includes(': ')) {
    const key = line.slice(0, line.indexOf(': '))
    const value = line.slice(line.indexOf(': ') + 2).trim()
    map.set(key, libmime.decodeWords(value))
    tempKey = key
  }
  return [map, tempKey]
}

/**
 * エンコードされたコンテンツ（HTML・画像ファイルなど）をデコードします。
 *
 * @param encoding エンコード形式
 * @param content エンコードされたコンテンツ
 * @returns デコードされたコンテンツ
 */
function decodeContent(encoding: string, content: string): string | Buffer {
  if (encoding === 'base64') {
    return Buffer.from(content.trim(), 'base64')
  } else if (encoding === 'quoted-printable') {
    return utf8.decode(quotedPrintable.decode(content))
  }
  return content
}

/**
 * mhtファイルをパースします。
 * まずはこの関数を呼び出して Mhtml オブジェクトを取得してください。
 *
 * @param mhtml mhtファイルの文字列
 * @returns Mhtml オブジェクト
 */
export function parseMhtml(mhtml: string): Mhtml {
  let headers: Map<string, string> = new Map<string, string>()
  let contents = ''
  const parts: MhtmlPart[] = []
  let headerKeyTemp = ''
  let partContentTemp = ''

  let mode: 'headers' | 'content' | 'part-header' | 'part-content' = 'headers'
  for (const line of mhtml.split('\r\n')) {
    if (mode === 'headers') {
      ;[headers, headerKeyTemp] = processHeader(headers, headerKeyTemp, line)
      if (line.length === 0) {
        mode = 'content'
        continue
      }
    }

    if (mode === 'content' && !line.startsWith('------=')) {
      contents += line + '\r\n'
    }

    if (line.startsWith('------=')) {
      if (partContentTemp.length > 0) {
        parts[parts.length - 1].content = decodeContent(
          parts[parts.length - 1].headers.get('Content-Transfer-Encoding')!,
          partContentTemp
        )
        partContentTemp = ''
      }

      const part = new MhtmlPart(
        line.substring(line.indexOf('------=_') + '------=_'.length)
      )
      parts.push(part)

      mode = 'part-header'
      continue
    }

    if (mode === 'part-header') {
      ;[parts[parts.length - 1].headers, headerKeyTemp] = processHeader(
        parts[parts.length - 1].headers,
        headerKeyTemp,
        line
      )
      if (line.trim().length === 0) {
        mode = 'part-content'
        continue
      }
    }

    if (mode === 'part-content') {
      partContentTemp += '\r\n' + line
    }
  }
  if (partContentTemp.length > 0) {
    parts[parts.length - 1].content = partContentTemp
    partContentTemp = ''
  }

  contents = contents.trim()

  const toc: MToc[] | null = getToc(parts)

  return new Mhtml(headers, contents, toc, parts)
}

/**
 * ファイルURL（file://...）をblob URL（blob:http://...）に置換します。
 * 同時に、別タブで開くよう target="_blank" を付与します。
 *
 * @param html HTML 文字列
 * @param fileUri ファイル URL
 * @param blobUri blob URL
 * @returns 置換された HTML 文字列
 */
function replaceFileUri(
  html: string,
  fileUri: string,
  blobUri: string
): string {
  let temp = html.replaceAll(fileUri, blobUri)
  for (const a of temp.matchAll(/<a (.+?)>/g)) {
    if (a[1].includes('target=')) continue
    temp = temp.replace(a[0], `<a ${a[1]} target="_blank">`)
  }
  return temp
}

/**
 * 各パートの Content-Location をもとに、HTML からリンクを検索し blob URL に置換します。
 *
 * @param parts パートのリスト
 * @param html HTML 文字列
 * @returns 置換された HTML 文字列
 */
export async function replaceLink(
  parts: MhtmlPart[],
  html: string
): Promise<string> {
  for (const match of html.matchAll(/file:\/\/\/([^"]+)/g)) {
    const fileUri = match[0]
    const part = parts.find(
      (p) =>
        p.headers.has('Content-Location') &&
        p.headers.get('Content-Location') === fileUri
    )
    if (part === undefined) {
      continue
    }
    if (part.content === undefined) {
      continue
    }
    let content = part.content
    if (!(part.content instanceof Buffer)) {
      content = await replaceLink(parts, part.content)
    }
    const blob = new Blob([content], {
      type: part.headers.get('Content-Type'),
    })
    const reader = new FileReader()
    reader.readAsDataURL(blob)
    const blobUri = await new Promise<string>((resolve) => {
      reader.onload = (): void => {
        resolve(window.URL.createObjectURL(blob))
      }
    })

    html = replaceFileUri(html, fileUri, blobUri)
  }
  return html
}

/**
 * 指定された URL に合致する text/html のパートを返します。
 *
 * @param parts パートのリスト
 * @param url URL
 * @returns 合致する text/html パート
 */
export function getPart(
  parts: MhtmlPart[],
  url: string
): MhtmlPart | undefined {
  return parts.find(
    (part) =>
      part.headers.has('Content-Type') &&
      part.headers.get('Content-Type')?.startsWith('text/html') &&
      part.headers.has('Content-Location') &&
      part.headers.get('Content-Location') === url
  )
}

/**
 * Content-Location が file:///frame であるパートを探し返します。
 * このパートは、iframe の構成パートです。（左側にメインコンテンツ、右側に目次のページを出すようにしている iframe コード）
 *
 * @param parts パートのリスト
 * @returns Content-Location が file:///frame であるパート
 */
export function getFramePart(parts: MhtmlPart[]): MhtmlPart | undefined {
  return parts.find(
    (part: MhtmlPart) =>
      part.headers.has('Content-Type') &&
      part.headers.get('Content-Type')?.startsWith('text/html') &&
      part.headers.has('Content-Location') &&
      part.headers.get('Content-Location') === 'file:///frame'
  )!
}

/**
 * Content-Location が file:///frame ではなく、Content-Type が text/html であるパートのうち、最初に見つかったパートを返します。
 * このパートは、メインコンテンツが含まれているパートになります。
 *
 * @param parts パートのリスト
 * @returns 対象のパート
 */
export function getMainPart(parts: MhtmlPart[]): MhtmlPart | undefined {
  return parts.find(
    (part: MhtmlPart) =>
      part.headers.has('Content-Type') &&
      part.headers.get('Content-Type')?.startsWith('text/html') &&
      part.headers.has('Content-Location') &&
      part.headers.get('Content-Location') !== 'file:///frame'
  )
}

/**
 * Content-Location が file:///toc であるパートを探し、MToc オブジェクトを返します。
 * このパートは、目次のページです。
 *
 * @param parts パートのリスト
 * @returns MToc
 */
export function getToc(parts: MhtmlPart[]): MToc[] | null {
  const tocPart = parts.find(
    (part: MhtmlPart) =>
      part.headers.has('Content-Type') &&
      part.headers.get('Content-Type')?.startsWith('text/html') &&
      part.headers.has('Content-Location') &&
      part.headers.get('Content-Location') === 'file:///toc'
  )
  if (tocPart === undefined) {
    return null
  }
  const content = tocPart.content as string
  const tocs: MToc[] = []
  for (const match of content.matchAll(
    /<li><a target="content" href="(file:\/\/\/.+?)".*?>(.+?)<\/a><\/li>/g
  )) {
    const url = match[1].trim()
    const title = match[2].trim()
    const part = parts.find(
      (part) =>
        part.headers.has('Content-Location') &&
        part.headers.get('Content-Location') === url
    )
    if (part === undefined) {
      continue
    }
    tocs.push(new MToc(title, url, part))
  }
  return tocs
}

/**
 * メイン iframe の blob URL を返します。
 *
 * @param data HTML データ
 * @returns メイン iframe の blob URL (非同期)
 */
export function getIframeUrl(data: string): Promise<string> {
  const blob = new Blob([data], { type: 'text/html' })
  const reader = new FileReader()
  reader.readAsDataURL(blob)
  return new Promise<string>((resolve) => {
    reader.onload = (): void => {
      resolve(window.URL.createObjectURL(blob))
    }
  })
}