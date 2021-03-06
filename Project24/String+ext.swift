#!/usr/bin/swift
import Foundation



extension String {
	func withPrefix(_ prefix: String) -> String {
		let check =  self.hasPrefix(prefix)
		if check {
			return self
		}
		print(check)
		return prefix + self
	}
	
	var isNumeric: Bool {
		for c in self {
			for i in 0...9 {
				if let n = Int(String(c)){
					if n == i { return true } }
			}
		}
		return false
	}
	
	func lineArray() -> [String] {
		var arr: [String] = []
		var newStr = ""
		
		for c in self {
			if c == "\n" {
				arr.append(newStr)
				newStr = ""
			} else {
				print(c)
				newStr += String(c)
			}
		}
		
		arr.append(newStr)
		return arr
	}
	
}


//
//
///*
//	Create a String extension that adds a withPrefix() method.
//	If the string already contains the prefix it should return
//	itself; if it doesn’t contain the prefix, it should return
//	itself with the prefix added. For
//	example: "pet".withPrefix("car") should return “carpet”.A
//*/
//
//let str = "#SwiftLang"
//
//extension String {
//	func withPrefix(_ prefix: String) -> String {
//		let check =  self.hasPrefix(prefix)
//		if check {
//			return self
//		}
//		print(check)
//		return prefix + self
//	}
//}
//
////let test = str.withPrefix("I love ")
////print(test)
//
//
///*
//Create a String extension that adds an isNumeric property
//that returns true if the string holds any sort of number.
//Tip: creating a Double from a String is a failable initializer.
//
//*/
//
//extension String {
//	var isNumeric: Bool {
//		for c in self {
//			for i in 0...9 {
//				if let n = Int(String(c)){
//					if n == i { return true } }
//			}
//		}
//		return false
//	}
//}
//
////
////let num = "This number  is no luck!"
////print(num.isNumeric)
///*
//Create a String extension that adds a lines property that
//returns an array of all the lines in a string. So,
//“this\nis\na\ntest” should return an array with four elements.
//*/
//
//extension String {
//	func lineArray() -> [String] {
//		var arr: [String] = []
//		var newStr = ""
//
//		for c in self {
//			if c == "\n" {
//				arr.append(newStr)
//				newStr = ""
//			} else {
//				print(c)
//				newStr += String(c)
//			}
//		}
//
//		arr.append(newStr)
//		return arr
//	}
//}
//
//
//
//
