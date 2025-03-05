////
//  FestFontAndBaseLine
//  LetterView
//
//  Created by LegoEsprit on 28.02.25.
//  Copyright (c) 2025 LegoEsprit
//

import AppKit

class ContentView: NSTextField {
    
    
}

/// Usage:
/// func foo(_ bytes: [UInt8]) -> UInt32 {
///   return UInt32(littleEndianBytes: bytes)
/// }
/// from: https://forums.swift.org/t/convert-uint8-to-int/30117/12
extension FixedWidthInteger {
    init<I>(littleEndianBytes iterator: inout I)
    where I: IteratorProtocol, I.Element == UInt8 {
        self = stride(from: 0, to: Self.bitWidth, by: 8).reduce(into: 0) {
            $0 |= Self(truncatingIfNeeded: iterator.next()!) &<< $1
        }
    }
    
    init<C>(littleEndianBytes bytes: C) where C: Collection, C.Element == UInt8 {
        precondition(bytes.count == (Self.bitWidth+7)/8)
        var iter = bytes.makeIterator()
        self.init(littleEndianBytes: &iter)
    }
}


class LetterView: NSView {
    
    @IBOutlet weak var lowerLine: NSBox!
    @IBOutlet weak var upperLine: NSBox!
    
    let sizeDict = [
        "Academy Engraved LET": (200.0, -49.5),
        "Adelle Sans Devanagari": (186.85121107266437, 13.5),
        "Adobe Caslon Pro": (189.47368421052633, -96.0),
        "AkayaKanadaka": (206.89655172413794, -35.5),
        "AkayaTelivigala": (206.89655172413794, -35.5),
        "Al Bayan": (188.8111888111888, -48.5),
        "Al Nile": (188.8111888111888, -78.5),
        "Al Tarikh": (188.8111888111888, -130.5),
        "American Typewriter": (200.0, -53.5),
        "Andale Mono": (196.36363636363637, -57.5),
        "Annai MN": (164.6341463414634, -47.5),
        "Apple Braille": (188.8111888111888, -88.0),
        "Apple Chancery": (194.24460431654677, -14.5),
        "Apple Color Emoji": (188.8111888111888, -46.5),
        "Apple LiGothic": (223.1404958677686, -49.5),
        "Apple LiSung": (217.74193548387098, -54.5),
        "Apple SD Gothic Neo": (201.49253731343285, -63.0),
        "Apple Symbols": (251.1627906976744, -68.5),
        "AppleGothic": (172.52396166134184, -81.5),
        "AppleMyungjo": (187.5, -72.5),
        "Arial": (188.8111888111888, -64.5),
        "Arial Black": (188.8111888111888, -27.5),
        "Arial Hebrew": (188.8111888111888, -97.5),
        "Arial Hebrew Scholar": (188.8111888111888, -97.5),
        "Arial Narrow": (188.8111888111888, -58.5),
        "Arial Rounded MT Bold": (182.43243243243242, -60.0),
        "Arial Unicode MS": (188.8111888111888, -33.5),
        "Arima Koshi": (189.47368421052633, -30.5),
        "Arima Madurai": (189.47368421052633, -30.5),
        "Avenir": (190.81272084805653, -44.5),
        "Avenir Next": (190.81272084805653, -44.5),
        "Avenir Next Condensed": (190.81272084805653, -44.5),
        "Ayuthaya": (178.21782178217822, -45.5),
        "Baghdad": (188.8111888111888, -62.5),
        "Bai Jamjuree": (192.85714285714286, -42.5),
        "Baloo 2": (217.74193548387098, -5.0),
        "Baloo Bhai 2": (217.74193548387098, -5.0),
        "Baloo Bhaijaan": (218.6234817813765, -4.0),
        "Baloo Bhaina 2": (217.74193548387098, 24.0),
        "Baloo Chettan 2": (217.74193548387098, -5.0),
        "Baloo Da 2": (217.74193548387098, 4.0),
        "Baloo Paaji 2": (217.74193548387098, 18.0),
        "Baloo Tamma 2": (217.74193548387098, -5.0),
        "Baloo Tammudu 2": (217.74193548387098, 22.0),
        "Baloo Thambi 2": (217.74193548387098, -5.0),
        "Bangla MN": (183.6734693877551, -42.5),
        "Bangla Sangam MN": (198.52941176470588, -74.5),
        "Bank Gothic": (262.13592233009706, -28.5),
        "Baoli SC": (243.24324324324326, 31.5),
        "Baoli TC": (243.24324324324326, 31.5),
        "Baskerville": (204.54545454545453, -51.5),
        "Beirut": (188.15331010452962, -91.5),
        "BiauKaiHK": (208.4942084942085, -56.5),
        "BiauKaiTC": (208.4942084942085, -56.5),
        "Bickham Script Pro": (312.1387283236994, -17.5),
        "Big Caslon": (187.5, -60.5),
        "Blackmoor LET": (194.94584837545128, -32.0),
        "BlairMdITC TT": (186.85121107266437, -55.5),
        "BM Dohyeon": (158.8235294117647, -84.5),
        "BM Hanna 11yrs Old": (185.56701030927834, -78.0),
        "BM Hanna Air": (200.0, -70.5),
        "BM Hanna Pro": (185.56701030927834, -78.0),
        "BM Jua": (188.15331010452962, -68.0),
        "BM Kirang Haerang": (229.7872340425532, -45.0),
        "BM Yeonsung": (214.28571428571428, -61.5),
        "Bodoni 72": (194.24460431654677, -53.5),
        "Bodoni 72 Oldstyle": (194.24460431654677, -53.5),
        "Bodoni 72 Smallcaps": (194.24460431654677, -53.5),
        "Bodoni Ornaments": (146.7391304347826, -92.0),
        "Bordeaux Roman Bold LET": (203.00751879699249, -50.5),
        "Bradley Hand": (233.76623376623377, -23.0),
        "Brush Script MT": (197.08029197080293, -48.0),
        "Caflisch Script Pro": (276.9230769230769, -42.5),
        "Cambay Devanagari": (245.45454545454547, -14.5),
        "Canela": (184.93150684931507, -13.5),
        "Canela Deck": (184.93150684931507, -13.5),
        "Canela Text": (184.93150684931507, -13.5),
        "Capitals": (162.16216216216216, -73.5),
        "Casual": (200.74349442379182, -27.5),
        "Chakra Petch": (192.85714285714286, -44.5),
        "Chalkboard": (196.36363636363637, -42.5),
        "Chalkboard SE": (194.94584837545128, -13.0),
        "Chalkduster": (155.61959654178673, -75.5),
        "Charm": (189.47368421052633, -22.5),
        "Charmonman": (168.22429906542055, -16.5),
        "Charter": (201.49253731343285, -38.5),
        "Cochin": (206.10687022900763, -50.0),
        "Comic Sans MS": (174.19354838709677, -37.5),
        "Copperplate": (257.14285714285717, -39.5),
        "Corsiva Hebrew": (188.8111888111888, -117.5),
        "Courier New": (236.8421052631579, -38.5),
        "Cracked": (192.85714285714286, -63.0),
        "Cymbol": (188.8111888111888, -67.5),
        "Damascus": (188.8111888111888, -125.5),
        "DecoType Naskh": (188.8111888111888, -13.5),
        "DejaVu Sans": (185.56701030927834, -63.5),
        "DejaVu Sans Mono": (185.56701030927834, -63.5),
        "DejaVu Serif": (185.56701030927834, -63.5),
        "Devanagari MT": (204.54545454545453, -46.5),
        "Devanagari Sangam MN": (198.52941176470588, -51.5),
        "Didot": (190.14084507042253, -56.5),
        "DIN Alternate": (190.14084507042253, -57.5),
        "DIN Condensed": (190.14084507042253, -100.5),
        "Diwan Kufi": (188.8111888111888, 27.5),
        "Diwan Thuluth": (188.8111888111888, -44.5),
        "Euphemia UCAS": (176.47058823529412, -42.5),
        "Fahkwang": (192.85714285714286, -41.5),
        "Farah": (188.8111888111888, -93.5),
        "Farisi": (188.8111888111888, -26.5),
        "Futura": (179.40199335548172, -49.5),
        "Galvji": (186.20689655172413, -55.5),
        "GB18030 Bitmap": (188.8111888111888, -23.5),
        "Geeza Pro": (188.8111888111888, -66.5),
        "Geneva": (178.21782178217822, -57.5),
        "Georgia": (194.94584837545128, -56.5),
        "Gill Sans": (198.52941176470588, -53.5),
        "Gotu": (184.93150684931507, -27.5),
        "Grantha Sangam MN": (198.52941176470588, 6.5),
        "Graphik": (188.8111888111888, -27.5),
        "Graphik Compact": (188.8111888111888, -27.5),
        "Graphite Std": (204.54545454545453, -103.0),
        "Gujarati MT": (204.54545454545453, -49.5),
        "Gujarati Sangam MN": (161.67664670658684, -65.5),
        "GungSeo": (234.7826086956522, -47.5),
        "Gurmukhi MN": (209.30232558139534, -37.0),
        "Gurmukhi MT": (187.5, -73.5),
        "Gurmukhi Sangam MN": (198.52941176470588, -37.5),
        "Handwriting - Dakota": (219.5121951219512, -2.5),
        "Hannotate SC": (192.85714285714286, -31.0),
        "Hannotate TC": (192.85714285714286, -31.0),
        "HanziPen SC": (180.0, -40.5),
        "HanziPen TC": (180.0, -40.5),
        "HeadLineA": (201.49253731343285, -74.5),
        "Hei": (203.00751879699249, -73.5),
        "Heiti SC": (188.15331010452962, -84.5),
        "Heiti TC": (188.15331010452962, -84.5),
        "Helvetica": (188.8111888111888, -52.5),
        "Helvetica Neue": (189.47368421052633, -55.5),
        "Herculanum": (220.40816326530611, -58.0),
        "Hiragino Maru Gothic ProN": (170.8860759493671, -83.5),
        "Hiragino Mincho ProN": (186.20689655172413, -77.5),
        "Hiragino Sans": (181.20805369127515, -76.5),
        "Hiragino Sans CNS": (177.6315789473684, -80.5),
        "Hiragino Sans GB": (177.6315789473684, -80.5),
        "Hoefler Text": (194.94584837545128, -54.5),
        "Hubballi": (253.5211267605634, 20.0),
        "Impact": (170.8860759493671, -63.5),
        "InaiMathi": (204.54545454545453, -61.5),
        "ITF Devanagari": (204.54545454545453, -20.5),
        "ITF Devanagari Marathi": (204.54545454545453, -20.5),
        "Jaini": (188.8111888111888, -42.5),
        "Jaini Purva": (188.8111888111888, -42.5),
        "Jazz LET": (203.00751879699249, -48.5),
        "jsMath-cmbx10": (197.08029197080293, -87.5),
        "jsMath-cmex10": (96.42857142857143, -26.5),
        "jsMath-cmmi10": (197.8021978021978, -87.5),
        "jsMath-cmr10": (197.8021978021978, -86.5),
        "jsMath-cmsy10": (197.8021978021978, -80.5),
        "jsMath-cmti10": (197.8021978021978, -86.5),
        "K2D": (188.8111888111888, -36.0),
        "KahoeTech": (197.8021978021978, -35.5),
        "Kai": (203.00751879699249, -73.5),
        "Kailasa": (188.8111888111888, -76.5),
        "Kaiti SC": (214.28571428571428, -21.0),
        "Kaiti TC": (214.28571428571428, -21.0),
        "Kannada MN": (209.30232558139534, -49.0),
        "Kannada Sangam MN": (198.52941176470588, -42.5),
        "Katari": (217.74193548387098, -39.0),
        "Kavivanar": (169.81132075471697, -48.0),
        "Kefa": (203.00751879699249, -46.5),
        "Khmer MN": (233.76623376623377, -4.5),
        "Khmer Sangam MN": (195.65217391304347, -16.5),
        "Klee": (188.8111888111888, -67.5),
        "Kodchasan": (188.15331010452962, -41.0),
        "Kohinoor Bangla": (192.85714285714286, -32.5),
        "Kohinoor Devanagari": (192.85714285714286, -32.5),
        "Kohinoor Gujarati": (188.8111888111888, -37.5),
        "Kohinoor Telugu": (192.85714285714286, -32.5),
        "KoHo": (192.85714285714286, -33.5),
        "Kokonor": (194.24460431654677, -28.5),
        "Kozuka Gothic Pr6N": (177.6315789473684, -79.5),
        "Kozuka Mincho Pr6N": (182.43243243243242, -74.5),
        "Krub": (192.85714285714286, -41.5),
        "Krungthep": (180.0, -53.5),
        "KufiStandardGK": (188.8111888111888, -57.5),
        "Lahore Gurmukhi": (188.8111888111888, -37.5),
        "Lantinghei SC": (174.19354838709677, -50.5),
        "Lantinghei TC": (174.19354838709677, -50.5),
        "Lao MN": (209.30232558139534, -49.0),
        "Lao Sangam MN": (198.52941176470588, -36.5),
        "Lava Devanagari": (194.94584837545128, -90.5),
        "Lava Kannada": (194.94584837545128, -26.5),
        "Lava Telugu": (194.94584837545128, 8.5),
        "Libian SC": (205.32319391634982, -6.0),
        "Libian TC": (205.32319391634982, -6.0),
        "LiHei Pro": (184.93150684931507, -78.0),
        "LingWai SC": (202.24719101123594, -33.0),
        "LingWai TC": (202.24719101123594, -33.0),
        "LiSong Pro": (197.08029197080293, -69.0),
        "Lithos Pro": (188.15331010452962, -95.0),
        "Lucida Grande": (186.85121107266437, -54.5),
        "Luminari": (182.43243243243242, -53.0),
        "Maku": (205.32319391634982, 30.5),
        "Malayalam MN": (209.30232558139534, -26.0),
        "Malayalam Sangam MN": (198.52941176470588, -74.5),
        "Mali": (192.85714285714286, -32.0),
        "Marker Felt": (157.89473684210526, -93.0),
        "MathMode": (197.8021978021978, -43.5),
        "Menlo": (185.56701030927834, -63.5),
        "Microsoft Sans Serif": (188.8111888111888, -61.5),
        "Minion Pro": (207.69230769230768, -84.5),
        "Mishafi": (188.15331010452962, -87.5),
        "Mishafi Gold": (188.15331010452962, -87.5),
        "Modak": (206.89655172413794, -27.5),
        "Mona Lisa Solid ITC TT": (170.8860759493671, -72.5),
        "Monaco": (178.21782178217822, -57.5),
        "Mshtakan": (204.54545454545453, -53.5),
        "Mukta": (214.28571428571428, 6.5),
        "Mukta Mahee": (214.28571428571428, 6.5),
        "Mukta Malar": (214.28571428571428, 6.5),
        "Mukta Vaani": (214.28571428571428, 6.5),
        "Muna": (188.8111888111888, -96.5),
        "Myanmar MN": (209.30232558139534, -32.0),
        "Myanmar Sangam MN": (198.52941176470588, -52.5),
        "Myriad Pro": (200.74349442379182, -84.5),
        "Myriad Web Pro": (200.74349442379182, -57.5),
        "Nadeem": (188.8111888111888, -62.5),
        "Nanum Brush Script": (274.11167512690355, -17.0),
        "Nanum Gothic": (183.05084745762713, -60.0),
        "Nanum Myeongjo": (185.56701030927834, -66.0),
        "Nanum Pen Script": (327.27272727272725, 13.5),
        "New Peninim MT": (188.8111888111888, -98.5),
        "New York": (191.48936170212767, -53.5),
        "New York Extra Large": (191.48936170212767, -53.5),
        "New York Large": (191.48936170212767, -53.5),
        "New York Medium": (191.48936170212767, -53.5),
        "New York Small": (191.48936170212767, -53.5),
        "Niramit": (192.85714285714286, -22.5),
        "Noteworthy": (148.7603305785124, -38.5),
        "Noto Nastaliq Urdu": (188.8111888111888, 123.5),
        "Noto Sans Batak": (188.8111888111888, -33.5),
        "Noto Sans Kannada": (188.8111888111888, -82.5),
        "Noto Sans Myanmar": (188.8111888111888, 14.5),
        "Noto Sans NKo": (188.8111888111888, -33.5),
        "Noto Sans Oriya": (188.8111888111888, -62.5),
        "Noto Sans Tagalog": (188.8111888111888, -33.5),
        "Noto Serif Kannada": (188.8111888111888, -41.5),
        "Noto Serif Myanmar": (188.8111888111888, -1.5),
        "Nueva Std": (218.6234817813765, -86.0),
        "October Compressed Devanagari": (175.32467532467533, -102.0),
        "October Compressed Tamil": (175.32467532467533, -102.0),
        "October Condensed Devanagari": (174.19354838709677, -101.5),
        "October Condensed Tamil": (174.19354838709677, -101.5),
        "October Devanagari": (173.63344051446944, -103.0),
        "October Tamil": (173.63344051446944, -103.0),
        "Optima": (197.08029197080293, -54.0),
        "Oriya MN": (209.30232558139534, -49.0),
        "Oriya Sangam MN": (169.27899686520377, -57.5),
        "Osaka": (178.21782178217822, -57.5),
        "Padyakke Expanded One": (259.61538461538464, -24.5),
        "Palatino": (193.5483870967742, -33.5),
        "Papyrus": (201.49253731343285, -44.5),
        "Party LET": (203.00751879699249, -27.5),
        "PCMyungjo": (198.52941176470588, -76.5),
        "Phosphate": (203.00751879699249, -44.5),
        "PilGi": (201.49253731343285, -73.5),
        "PingFang HK": (189.47368421052633, -34.5),
        "PingFang SC": (189.47368421052633, -34.5),
        "PingFang TC": (189.47368421052633, -34.5),
        "Plantagenet Cherokee": (198.52941176470588, -96.5),
        "Poplar Std": (180.0, -97.5),
        "PortagoITC TT": (188.15331010452962, -50.0),
        "Postino Std": (192.17081850533808, -92.0),
        "Princetown LET": (203.00751879699249, -48.5),
        "Produkt": (188.8111888111888, -35.5),
        "Proxima Nova": (203.00751879699249, -34.5),
        "PSL Ornanong Pro": (207.69230769230768, -10.5),
        "PT Mono": (192.85714285714286, -64.5),
        "PT Sans": (192.85714285714286, -61.5),
        "PT Sans Caption": (192.85714285714286, -61.5),
        "PT Sans Narrow": (192.85714285714286, -61.5),
        "PT Serif": (192.85714285714286, -39.5),
        "PT Serif Caption": (192.85714285714286, -39.5),
        "Publico Text": (194.94584837545128, -11.5),
        "Raanana": (204.54545454545453, -89.5),
        "Rockwell": (183.6734693877551, -110.5),
        "Sama Devanagari": (188.8111888111888, -14.5),
        "Sama Gujarati": (188.8111888111888, -30.5),
        "Sama Gurmukhi": (188.8111888111888, -27.5),
        "Sama Kannada": (188.8111888111888, -46.5),
        "Sama Malayalam": (188.8111888111888, -51.5),
        "Sama Tamil": (188.8111888111888, -46.5),
        "Sana": (188.8111888111888, -94.5),
        "Santa Fe LET": (178.21782178217822, -99.0),
        "Sarabun": (192.85714285714286, -29.5),
        "Sathu": (178.80794701986756, -29.5),
        "Savoye LET": (203.00751879699249, -93.0),
        "SchoolHouse Cursive B": (205.32319391634982, -64.5),
        "SchoolHouse Printed A": (137.05583756345177, -71.5),
        "SF Compact": (203.00751879699249, -42.5),
        "SF Compact Display": (203.00751879699249, -42.5),
        "SF Compact Rounded": (199.2619926199262, -44.5),
        "SF Compact Text": (203.00751879699249, -42.5),
        "SF Mono": (192.17081850533808, -52.5),
        "SF Pro": (192.17081850533808, -52.5),
        "SF Pro Display": (192.17081850533808, -52.5),
        "SF Pro Rounded": (188.15331010452962, -55.0),
        "SF Pro Text": (192.17081850533808, -52.5),
        "Shobhika": (192.85714285714286, -17.5),
        "Shree Devanagari 714": (183.6734693877551, -65.5),
        "SignPainter": (213.43873517786562, -83.5),
        "Silom": (180.0, -16.5),
        "SimSong": (197.08029197080293, -69.0),
        "Sinhala MN": (209.30232558139534, -49.0),
        "Sinhala Sangam MN": (198.52941176470588, -31.5),
        "Skia": (199.2619926199262, -38.0),
        "Snell Roundhand": (188.15331010452962, -58.0),
        "Songti SC": (213.43873517786562, -21.5),
        "Songti TC": (213.43873517786562, -21.5),
        "Srisakdi": (190.14084507042253, -52.5),
        "Stencil Std": (180.6020066889632, -100.5),
        "STFangsong": (213.43873517786562, -63.5),
        "STHeiti": (188.15331010452962, -84.5),
        "STIX Two Math": (206.10687022900763, -78.5),
        "STIX Two Text": (206.10687022900763, -78.5),
        "STKaiti": (214.28571428571428, -21.0),
        "Stone Sans ITC TT": (188.15331010452962, -46.5),
        "Stone Sans Sem ITC TT": (188.15331010452962, -50.5),
        "STSong": (214.28571428571428, -21.0),
        "Sukhumvit Set": (200.74349442379182, -14.5),
        "Symbol": (188.8111888111888, -103.5),
        "Synchro LET": (201.49253731343285, -25.0),
        "Tahoma": (186.20689655172413, -49.5),
        "Tamil MN": (209.30232558139534, -49.0),
        "Tamil Sangam MN": (198.52941176470588, -41.5),
        "Tekton Pro": (208.4942084942085, -92.5),
        "Telugu MN": (209.30232558139534, -49.0),
        "Telugu Sangam MN": (184.30034129692834, -53.5),
        "Thonburi": (178.21782178217822, -42.5),
        "Times New Roman": (204.54545454545453, -53.5),
        "Tiro Bangla": (192.85714285714286, -89.5),
        "Tiro Devanagari Hindi": (192.85714285714286, -89.5),
        "Tiro Devanagari Marathi": (192.85714285714286, -89.5),
        "Tiro Devanagari Sanskrit": (192.85714285714286, -89.5),
        "Tiro Gurmukhi": (192.85714285714286, -89.5),
        "Tiro Kannada": (192.85714285714286, -89.5),
        "Tiro Tamil": (192.85714285714286, -89.5),
        "Tiro Telugu": (192.85714285714286, -89.5),
        "Toppan Bunkyu Gothic": (180.0, -77.5),
        "Toppan Bunkyu Midashi Gothic": (173.07692307692307, -83.5),
        "Toppan Bunkyu Midashi Mincho": (180.0, -77.5),
        "Toppan Bunkyu Mincho": (189.47368421052633, -68.5),
        "Trajan Pro": (178.80794701986756, -101.0),
        "Trattatello": (217.74193548387098, 22.5),
        "Trebuchet MS": (188.8111888111888, -58.5),
        "Tsukushi A Round Gothic": (185.56701030927834, -74.0),
        "Tsukushi B Round Gothic": (187.5, -72.5),
        "Type Embellishments One LET": (203.00751879699249, -86.0),
        "Verdana": (186.20689655172413, -48.5),
        "Waseem": (188.8111888111888, -67.5),
        "Wawati SC": (201.49253731343285, -21.0),
        "Wawati TC": (201.49253731343285, -21.0),
        "Webdings": (190.81272084805653, -74.0),
        "Wingdings": (258.3732057416268, -29.5),
        "Wingdings 2": (186.85121107266437, -77.5),
        "Wingdings 3": (187.5, -61.5),
        "Xingkai SC": (197.08029197080293, -14.0),
        "Xingkai TC": (197.08029197080293, -14.0),
        "Yuanti SC": (190.81272084805653, -30.5),
        "Yuanti TC": (190.81272084805653, -30.5),
        "YuGothic": (183.05084745762713, -77.5),
        "YuKyokasho": (175.32467532467533, -81.5),
        "YuKyokasho Yoko": (175.32467532467533, -81.5),
        "YuMincho": (188.8111888111888, -75.0),
        "YuMincho +36p Kana": (188.8111888111888, -75.0),
        "Yuppy SC": (189.47368421052633, -35.0),
        "Yuppy TC": (189.47368421052633, -35.0),
        "Zapf Dingbats": (188.8111888111888, -81.5),
        "Zapfino": (108.0, -16.5)
    ]

    var textBounds: (lower: Double, upper: Double) = (0, 0)
    var viewController: ViewController = ViewController()
    

    fileprivate func showBounds() {
        textBounds = checkBounds2()
        if textBounds.lower >= 0 {
            lowerLine.frame = NSRect(origin: NSPoint(x: 0, y: bounds.height-textBounds.lower)
                                     , size: NSSize(width: bounds.width, height: 3)
            )
        }
        if textBounds.upper >= 0 {
            upperLine.frame = NSRect(origin: NSPoint(x: 0, y: bounds.height-textBounds.upper)
                                     , size: NSSize(width: bounds.width, height: 3)
            )
        }
        
    }
    
    var currentFontFamily = "Helvetica" {
        didSet {
            resizeSubviews(withOldSize: .zero)
        }
    }
    

    var label = ContentView(labelWithString: "O")


    override func awakeFromNib() {
        
        currentFontFamily = NSFontManager.shared.availableFontFamilies[0]
        
        lowerLine.boxType = .custom
        upperLine.boxType = .custom
        lowerLine.borderWidth = 3.0
        upperLine.borderWidth = 3.0
        lowerLine.borderColor = .red.withAlphaComponent(0.3)
        upperLine.borderColor = .red.withAlphaComponent(0.3)

      
        label.attributedStringValue = NSAttributedString(
            string: "X"
            , attributes: [NSAttributedString.Key.baselineOffset: 13]
        )
        
        label.alignment = .center
        
        addSubview(label)
        resizeSubviews(withOldSize: .zero)
    }
    
    /// Re- arrange the cells, so that they fill the bounds
    /// - Parameter oldSize: Ignored
    override func resizeSubviews(withOldSize oldSize: NSSize) {
        
        if let sizeOffset = sizeDict[currentFontFamily] {
            let size = sizeOffset.0
            let offset = sizeOffset.1
            label.font = NSFont(name: currentFontFamily, size: size) ?? NSFont.systemFont(ofSize: 200.0)
            label.frame = NSRect(x: 0.0, y: offset, width: bounds.width, height: bounds.height)
            showBounds()
        }
    }
    
    func printTextLine() {
    }

    /*
    func checkBounds() -> (lower: Double, upper: Double) {
        var l = 0.0
        var u = 0.0
        let scale = window?.backingScaleFactor ?? 1.0
        if let bdir = self.bitmapImageRepForCachingDisplay(in: bounds) {
            cacheDisplay(in: bounds, to: bdir)
            
            outerLoop: for y in 0..<bdir.pixelsWide {
                innerLoop: for x in 0..<bdir.pixelsWide {
                    if let c = bdir.colorAt(x: x, y: y) {
                        if c.alphaComponent > 0.5 {
                            u = Double(y) / scale
                            break outerLoop
                        }
                    }
                }
            }
            for y in stride(from: bdir.pixelsHigh - 1, to: Int(u)+1, by: -1) {
                for x in 0..<bdir.pixelsWide {
                    if let c = bdir.colorAt(x: x, y: Int(y)) {
                        if c.alphaComponent > 0.5 {
                            l = Double(y) / scale
                            return (l, u)
                        }
                    }
                }
            }
        }
        return (l, u)
    }
     */
    
    func rowIsEmpty(_ rowStart: UnsafeMutablePointer<UInt8>, width: Int, samplesPerPixel: Int) -> Bool {
        enum Colors: Int, RawRepresentable {
            case red
            case green
            case blue
            case alpha
        }
        let line = UnsafeMutableBufferPointer(start: rowStart, count: width)
        for (i, p) in line.enumerated() {
            switch i % samplesPerPixel {
            case Colors.alpha.rawValue:
                if p > 128 {
                    return false
                }
            default:
                break
            }
        }
        return true
    }
    
    func checkBounds2() -> (lower: Double, upper: Double) {
        var l = -1.0
        var u = -1.0
        let scale = window?.backingScaleFactor ?? 1.0
        if let bdir = self.bitmapImageRepForCachingDisplay(in: bounds) {
            cacheDisplay(in: bounds, to: bdir)
            
            if let ptr = bdir.bitmapData {
                let samplesPerPixel = bdir.samplesPerPixel
                let width = bdir.pixelsWide
                let height = bdir.pixelsHigh
                let rowBytes = bdir.bytesPerRow
                
                for row in 0..<height {
                    let rowStart = ptr + (row * rowBytes)
                    let empty = rowIsEmpty(rowStart, width: width, samplesPerPixel: samplesPerPixel)
                    if !empty {
                        l = Double(row) / scale
                        break
                    }
                }
                for row in stride(from: height-1, to: Int(l), by: -1) {
                    let rowStart = ptr + (row * rowBytes)
                    let empty = rowIsEmpty(rowStart, width: width, samplesPerPixel: samplesPerPixel)
                    if !empty {
                        u = Double(row) / scale
                        return (l, u)
                    }
                }
                
            }
        }
        return (l, u)
    }

}
