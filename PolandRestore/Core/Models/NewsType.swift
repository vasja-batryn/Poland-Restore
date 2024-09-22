//
//  NewsType.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import Foundation

enum NewsType: Int {
    // MARK: - Cases

    case rybolovles = 1
    case dollars
    case numismatics
    case nft
    case bibles
    case colect
    case poozeum

    var image: String {
        return "News-\(self.rawValue)"
    }
}

// MARK: - CustomStringConvertible

extension NewsType {
    var title: String {
        switch self {
        case .rybolovles:
            return "US court dismisses Rybolovlev's lawsuit against Sotheby'"
        case .dollars:
            return "In the U.S., collectors pay thousands of dollars for a one-dollar bill with a mistake"
        case .numismatics:
            return "In the fall of 2021, the United States gave numismatists a real gift"
        case .nft:
            return "Top NFT collections rose in value after the US Federal Reserve's recent rate hike"
        case .bibles:
            return "Trump has released a self-branded Bible for sale"
        case .colect:
            return "The largest art auction in history. The collection of the Microsoft co-founder will be sold in the USA"
        case .poozeum:
            return "In the United States, a collector has opened “Cacusei” - a museum of fossilized feces"
        }
    }

    var text: String {
        switch self {
        case .rybolovles:
            return "A New York court has dismissed Russian billionaire Dmitry Rybolovlev's lawsuit against auction house Sotheby's, Bloomberg reports. Rybolovlev claimed that Sotheby's helped his former art dealer Yves Bouvier to inflate prices for paintings. By the end of the trial, only four art deals remained among the billionaire's claims instead of the original 16 A jury in New York dismissed Russian billionaire Dmitry Rybolovlev's claims against auction house Sotheby's, Bloomberg reported at the end of a three-week trial. The jury sided with the auction house on four separate claims, the agency reports. Rybolovlev claimed that Sotheby's helped his former art dealer Yves Bouvier to cheat him - Bouvier set secret markups when reselling paintings to him."
        case .dollars:
            return "Some American coin and currency collectors are willing to pay thousands of dollars for rare one-dollar bills that have a certain printing error made by the U.S. Bureau of Engraving and Printing. Chad Hawk, vice president of PMG, a professional paper money appraisal company, told Fox Business that the U.S. Federal Reserve printed two sets of one-dollar bills, one in 2014 and one in 2016, with one specific error. As a result, more than 6 million misprinted one-dollar bills were sent into circulation before the error was discovered."
        case .numismatics:
            return "In the fall of 2021, the United States made a real gift to numismatists, preparing a limited edition collection of silver coins “American Eagle”. The collection of US coins includes six coins of different denominations, packed in an elegant box. A total of 50,000 sets of 999 silver coins minted as proof have come off the press. The reverse of the redesigned American Eagle coin features a landing eagle with an oak branch in its talons. The design was created by Emily Damstra and sculpted by Michael Gaudioso."
        case .nft:
            return "Minimum prices of some of the most popular collections of non-fungible tokens (NFTs) rose over the past 24 hours as the U.S. Federal Reserve (Fed) on Wednesday announced another rate hike in line with market expectations. According to NFT data provider DappRadar, minimum prices for popular NFT collections Mutant Ape Yacht Club, Bored Ape Yacht Club, Otherdeed for Otherside and CryptoPunks have risen more than 17% in the past 24 hours as of Thursday. The most optimistic among the four collections was Mutant Ape Yacht Club, whose minimum price rose nearly 27% in the last 24 hours to $27,390, according to DappRadar. CryptoPunks came in second place with a minimum price of $115,860, up 23% over the same time period."
        case .bibles:
            return "Donald Trump has started selling Bibles: the US presidential candidate has presented his own edition of the Holy Scripture with a modified campaign slogan - Make America Pray Again, which means “Make America Pray Again”. Trump's original slogan - Make America Great Again - translated as “Make America Great Again”. The website where the Bible is sold states that the proceeds will not be used to finance a political campaign. At the same time, the American media call Trump's decision to sell the book “an attempt to get additional income” and note that the politician “cannot cope with the growing legal expenses.” In the near future, Trump will have to make a bail of $ 175 million in the case of fraud."
        case .colect:
            return "Auction house Christie's will put up for auction a collection of works of art that belonged to the co-founder of Microsoft Paul Allen. This auction will be the largest in history: the total value of paintings are estimated at a billion dollars. The collection includes works by masters of the Renaissance (Botticelli), Impressionists (Renoir), as well as artists of the XX century - David Hockney and Roy Lichtenstein. In total, the auction, which will be held in the United States in November, will be exhibited 150 paintings painted during five centuries. With a hammer will also leave one of the paintings of the series “Mount St. Victoire” "
        case .poozeum:
            return "In the state of Arizona George Frandsen, who owns the Guinness record for the largest collection of fossilized feces, opened a museum in which he exhibited his findings. This is reported by the BBC. The museum is called “Kakuzey” (“Poozeum”). It presents thousands of okomenovyh feces, including one of the largest ever found. According to Frandsen, he decided to open the museum because of the lack of fossilized poop in other similar educational venues. The Cacuseum was originally founded in 2014 as a virtual resource center, but opened its doors in a permanent location last month."
        }
    }
}

// MARK: - CaseIterable

extension NewsType: CaseIterable {}

// MARK: - Identifiable

extension NewsType: Identifiable {
    var id: Int { rawValue }
}
