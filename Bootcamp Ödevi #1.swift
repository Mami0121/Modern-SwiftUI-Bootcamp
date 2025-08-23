import UIKit

/*
Ödev 1.1 – Değişkenler ve Veri Tipleri
Kendi kişisel bilgi kartınızı oluşturun.
Int, String, Bool, Double tiplerini kullanın.
Optional değişkenlerle güvenli kod yazımını deneyimleyin.
*/

// Kişisel bilgi kartı
var name: String = "Muhammet"
var age: Int = 26
var height: Double = 1.74
var isStudent: Bool = false

// Optional değişkenler (nil olabilirler)
var phoneNumber: String? = nil
var email: String? = "muhammet@deneme.com"

// Güvenli unwrap etme (Optional Binding)
if let phone = phoneNumber {
    print("Telefon: \(phone)")
} else {
    print("Telefon numarası yok.")
}

// Kartı yazdırma
print("""
👤 Kişisel Bilgi Kartı
İsim: \(name)
Yaş: \(age)
Boy: \(height) m
Öğrenci mi?: \(isStudent)
Email: \(email ?? "Belirtilmedi")
""")

/*
 Ödev 1.2 – Fonksiyonlar ve Closure’lar
 Basit bir hesap makinesi fonksiyonu yazın (toplama, çıkarma, çarpma, bölme).
 Closure kullanarak bir diziyi filtreleyin ve sıralayın.
*/

func calculator(_ a: Double, _ b: Double, operation: String) -> Double? {
    switch operation {
    case "topla":
        return a + b
    case "çıkar":
        return a - b
    case "çarp":
        return a * b
    case "böl":
        return b != 0 ? a / b : nil  // Sıfıra bölme kontrolü
    default:
        return nil
    }
}

if let result = calculator(10, 5, operation: "çarp") {
    print("Sonuç: \(result)")
} else {
    print("Geçersiz işlem")
}


//Closure kullanarak bir diziyi filtreleyin ve sıralayın.
let numbers = [3, 7, 2, 9, 1, 6, 4]

// Çift sayıları filtrele
let evenNumbers = numbers.filter { $0 % 2 == 0 }
print("Çift Sayılar: \(evenNumbers)")

// Küçükten büyüğe sıralama
let sortedNumbers = numbers.sorted { $0 < $1 }
print("Sıralı Sayılar: \(sortedNumbers)")

