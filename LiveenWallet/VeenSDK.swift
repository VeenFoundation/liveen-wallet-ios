import UIKit
import KinSDK

enum APIError : Error {
    case ClientInitFailed
    case AccountCreationError
    case CannotCallBalanceOf
    case NotFoundAccount
    case TransactionError
}

class VeenAPI {
    private let kMainNetURL = "http://veenpf-dns-reg1.southeastasia.cloudapp.azure.com:8545"
    private let kTestNetURL = "https://ropsten.infura.io/0KyDWe43xirRn0m71Q2x"
    private let contractAddress = "0x873cd990852fc6b790abe2cc76c8947610fa6a28"
    
    private let KinAccountPassphrase = "AccountPassphrase"
    private var kinClient: KinClient
    
    public init() throws {
        guard let kinClient = try? KinClient(with: URL(string: kMainNetURL)!, networkId: .mainNet) else {
            throw APIError.ClientInitFailed
        }
        
        self.kinClient = kinClient;
    }
    
    public func hasAccount() -> Bool {
        return self.kinClient.accounts.count > 0
    }
    
    // 계좌 생성
    public func createAccount() throws -> KinAccount {
        guard let kinAccount = try? self.kinClient.addAccount(with: KinAccountPassphrase) else {
            throw APIError.AccountCreationError
        }
        
        return kinAccount
    }
    
    // get current account
    public func getAccount() throws -> KinAccount {
        if(self.kinClient.accounts.count == 0) {
            throw APIError.NotFoundAccount
        }
        
        return self.kinClient.accounts[0]!
    }
    
    public func getAccounts() -> KinAccounts {
        return self.kinClient.accounts
    }
    
    public func getCurentVeen() throws -> Int {
        guard let balance = try? self.kinClient.accounts[0]!.balance() else {
            throw APIError.CannotCallBalanceOf
        }
        
        return NSDecimalNumber(decimal: balance).intValue
    }
    
    public func transferVeen(to: String, amount: Int) throws -> TransactionId {
        guard let account = try? self.getAccount() else {
            throw APIError.NotFoundAccount
        }
        
        guard let transactionId = try? account.sendTransaction(to: to, kin: UInt64(amount), passphrase: KinAccountPassphrase) else {
            throw APIError.TransactionError
        }

        return transactionId
    }
    
    // get my gas
    

    // charge my gas
    

}
