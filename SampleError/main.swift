//
//  main.swift
//  SampleError
//
//  Created by Toshiyana on 2021/10/15.
//

import Foundation
        
//// エラー持ちのメソッド
//func methodA(text: String) throws {
//    if text.isEmpty {
//        throw NSError(domain: "error Message", code: -1, userInfo: nil)
//    }
//    print(text)
//}
//
////try methodA(text: "")


//// do-catch文
//// 例1
//struct APIError: Error {}
//
//do {
//    print("処理を実行しました")
//
//    // throwでエラーを投げる
//    throw APIError()
//
//    print("catchに飛ぶのでこの文は出力されない")
//
//} catch {
//
//    print("Error. \(error)")//catch節の定数errorでエラー詳細を取得
//}


//例2：catch部分でパターンマッチ
// パターンマッチ：条件を絞ってエラー処理が可能。
// パターンマッチのcatch節では定数errorは使用不可能。そのため、以下のように、明示的にエラーの定数を定義することで、エラーの詳細を取得可能。

//enum APIError: Error {
//    case network
//    case unexpected(String)
//}
//
//do {
//    throw APIError.unexpected("予期せぬエラーです")
//
//} catch APIError.unexpected(let unexpectedError) {
//    print("Error. \(unexpectedError)")
//}


// 例3：whereキーワードで条件の追加
// 以下は、データベースエラーが発生して、caseの引数の値を見てエラーを処理している。
//enum DBError: Error {
//    case db(Int)
//}
//
//
//do {
//    throw DBError.db(404)
//
//} catch DBError.db(let status) where status == 404 {
//    print("Error. \(status)")
//    print("Not Found.")
//}


//// 例4: throwsキーワード
//// 関数内でthrowを使う時（＝エラーを発生させる時）に利用
//
//// メソッド側
//enum SomeError: Error{
//    case unexpected(String)
//}
//
//func method() throws -> Void {
//    print("関数が呼び出されました")
//
//    throw SomeError.unexpected("予期せぬエラーが発生しました")
//}
//
//// 呼び出し側
//do {
//    try method() // tryでエラーを持つメソッドを呼び出し
//
//} catch SomeError.unexpected(let error) {
//    print("Error.\(error)")
//}

// 例4.1: 関数がネストされている場合
// 呼び出した関数のさらに先の別の関数でエラーを投げる場合、tryを使う
// catchの記述する位置で、エラーをキャッチする場所が決まる

//// * エラーキャッチが呼び出し元の場合
//enum SomeError: Error {
//    case unexpected(String)
//}
//
//do {
//    try method1()
//} catch SomeError.unexpected(let error) {
//    print("エラーをキャッチしました")
//    print(error)
//}
//
//func method1() throws -> Void {
//    do {
//        try method2()
//    }
//}
//
//func method2() throws -> Void {
//    do {
//        try method3()
//    }
//}
//
//func method3() throws -> Void {
//    throw SomeError.unexpected("Error")
//}

// * エラーキャッチがmethod2の場合
enum SomeError: Error {
    case unexpected(String)
}

do {
    try method1()
}

func method1() throws -> Void {
    do {
        try method2()
    }
}

func method2() throws -> Void {
    do {
        try method3()
    } catch SomeError.unexpected(let error) {
        print("エラーをキャッチしました")
        print(error)
    }
}

func method3() throws -> Void {
    throw SomeError.unexpected("Error")
}
